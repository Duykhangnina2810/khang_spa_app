import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../constants/app_settings.dart';

import '../../../constants/api_url.dart';
import '../../../core/nd_app.dart';
import '../../../core/service/api/dio_client.dart';
import '../model/auth_user_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepoProvider = Provider<AuthRepository>(
  (_) => AuthRepository(),
);

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  final _apiClient = DioClient(Dio());
  late final Box _boxAuth;

  AuthRepository() {
    init();
  }

  init() async {
    _boxAuth = await NdApp.localStorage.openBox(AppSettings.boxAuth);
  }

  saveToken(dynamic result) {
    NdApp.localStorage.saveBox(
        key: 'accessToken', value: result['accessToken'], box: _boxAuth);
    NdApp.localStorage.saveBox(
        key: 'refreshToken', value: result['refreshToken'], box: _boxAuth);
  }

  // lấy thông tin user từ API url
  Future<AuthUserModel?> getCurrentUserByEmail({required String email}) async {
    final response =
        await _apiClient.post(ApiUrl.userProfile, data: {'email': email});
    if (response.statusCode == 200) {
      final result = response.data;
      if (result['success'] == true) {
        saveToken(result);
        return await getCurrentUserById(id: result['id']);
      }
    }
    return null;
  }

  Future<AuthUserModel?> getCurrentUserById({required String id}) async {
    final response = await _apiClient.get('${ApiUrl.profileAuth}/$id');
    if (response.statusCode == 200) {
      final result = response.data;
      return AuthUserModel.fromJson(result['data']);
    }
    return null;
  }

  // update hình ảnh đại diện
  Future<Response> uploadAvatar(String id, File file) async {
    String fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(file.path, filename: fileName),
      'flag_avatar': true
    });
    final response =
        await _apiClient.post("${ApiUrl.uploadAvatar}/$id", data: formData);
    return response;
  }

  Future<dynamic> updateUser(id, data) async {
    final response = await _apiClient.post("${ApiUrl.updateProfile}/$id",
        data: jsonEncode(data));
    return response.toString();
  }

  // Đăng ký
  Future<Response> signUp({required Map<dynamic, dynamic> data}) async {
    try {
      return await _apiClient.post(ApiUrl.registerAuth, data: jsonEncode(data));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Đăng nhập
  Future<Response> signIn({required Map<dynamic, dynamic> data}) async {
    try {
      return await _apiClient.post(ApiUrl.loginAuth, data: jsonEncode(data));
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  // Quên mật khẩu
  Future<Response> forgotPassword({required Map<String, dynamic> data}) async {
    try {
      return await _apiClient.post(ApiUrl.forgotPassword,
          data: jsonEncode(data));
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> sendCodePassword({required String email}) async {
    try {
      return await _apiClient
          .post(ApiUrl.sendCodePassword, data: {"email": email});
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Đăng nhập bằng Google
  Future<AuthUserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithCredential(credential);

        AuthUserModel? user =
            await getCurrentUserByEmail(email: googleUser.email);

        // tài khoản mới đăng nhập google => không có hình đại diện
        if (user != null && (user.avatar == null || user.avatar == '')) {
          user = user.copyWith(
              avatar: googleUser.photoUrl
                  .toString()); // láy hình đại diện theo mạng xã hội
        }

        Map<String, String> intializeData = {};
        if (user != null && (user.fullName == null || user.fullName == '')) {
          var name = googleUser.displayName.toString().split(' ');
          intializeData['lastname'] = name[0];
          name = name..removeAt(0);
          intializeData['firstname'] = name.join(' ');
          intializeData['fullname'] = googleUser.displayName.toString();
          user = user.copyWith(fullName: intializeData['fullname']);
        }

        if (intializeData.isNotEmpty) {
          updateUser(user!.id, intializeData);
        }
        return user;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  // Đang nhập bằng Facebook
  Future<dynamic> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if(loginResult.status == LoginStatus.success){
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
        // Once signed in, return the UserCredential
        final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(facebookAuthCredential);

        AuthUserModel? user = await getCurrentUserByEmail(
            email: userCredential.additionalUserInfo!.profile!['email']);

        Map<String, String> intializeData = {};
        // tài khoản mới đăng nhập google => không có hình đại diện
        if (user != null && (user.avatar == null || user.avatar == '')) {
          user = user.copyWith(
              avatar: userCredential.additionalUserInfo!.profile!['picture']
              ['data']['url']); // láy hình đại diện theo mạng xã hội
        }

        if (user != null && (user.fullName == null || user.fullName == '')) {
          final lastName = userCredential.additionalUserInfo!.profile!['name'];
          final firstName =
          userCredential.additionalUserInfo!.profile!['first_name'];
          final fullName = userCredential.additionalUserInfo!.profile!['name'];
          intializeData['lastname'] = lastName;
          intializeData['firstname'] = firstName;
          intializeData['fullname'] = fullName;
          user = user.copyWith(fullName: fullName);
        }

        if (intializeData.isNotEmpty) {
          updateUser(user!.id, intializeData);
        }
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Apple
  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      return await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
