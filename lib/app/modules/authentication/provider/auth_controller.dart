import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import '../../../constants/app_settings.dart';

import '../../../core/nd_app.dart';
import '../repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/auth_user_model.dart';

part 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref),
);

class AuthController extends StateNotifier<AuthState> {
  final Ref ref;
  late final AuthRepository _authRepository;
  late final Box _boxAuth;

  AuthController(this.ref)
      : super(const AuthState(authStatus: AuthStatus.loading)) {
    init();
  }

  init() async {
    _authRepository = ref.watch(authRepoProvider);
    _boxAuth = await NdApp.localStorage
        .openBox(AppSettings.boxAuth); // mở box lưu thông tin user đăng nhập
    checkLoginUser(); // kiểm tra user đăng nhập
  }

  void onUserChanged({required AuthUserModel? user}) async {
    if (user != null) {
      saveAuth(user: user);
      state = state.copyWith(
          authStatus: AuthStatus.authenticated, authUserModel: user);
    } else {
      onSignOut(message: 'Tài khoản không đúng');
    }
  }

  changeAuthStatus({required AuthStatus authStatus}) {
    state = state.copyWith(authStatus: authStatus);
  }

  refreshAuthUserModel({required AuthUserModel newUser}) {
    state = state.copyWith(authUserModel: newUser);
  }

  Future<void> checkLoginUser() async {
    final strUserInfo =
        NdApp.localStorage.getBox(box: _boxAuth, key: 'user_login_info');
    if (strUserInfo != null) {
      final userLogin = jsonDecode(strUserInfo);
      final user =
          await _authRepository.getCurrentUserById(id: userLogin['_id']);
      state = state.copyWith(
          authStatus: AuthStatus.authenticated, authUserModel: user);
    } else {
      state = state.copyWith(
          authStatus: AuthStatus.unauthenticated, authUserModel: null);
    }
  }

  void onSignOut({String? message}) {
    _authRepository.signOut();
    clearAuth();
    state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        authUserModel: null,
        mess: message);
  }

  // Lưu thông tin đăng nhập vào Hive
  saveAuth({required AuthUserModel user}) {
    NdApp.localStorage.saveBox(
        box: _boxAuth,
        key: 'user_login_info',
        value: jsonEncode(user.toJson()));
  }

  // Xoá thông tin user đăng nhập Hive
  clearAuth() {
    NdApp.localStorage.deleteBox(box: _boxAuth, key: 'accessToken');
    NdApp.localStorage.deleteBox(box: _boxAuth, key: 'refreshToken');
    NdApp.localStorage.deleteBox(box: _boxAuth, key: 'user_login_info');
  }
}
