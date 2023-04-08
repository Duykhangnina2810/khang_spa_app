import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/repository/auth_repository.dart';

final profileProvider =
    StateNotifierProvider<ProfileController, ProfileState>((ref) {
  return ProfileController(ref);
});

enum ProfileState { init, loading, success, error }

class ProfileController extends StateNotifier<ProfileState> {
  final AuthRepository _authRepository = AuthRepository();
  final Ref ref;
  ProfileController(this.ref) : super(ProfileState.init);

  updateProfileAvatar({required String idUser, required File file}) async {
    state = ProfileState.loading;
    final Response response = await _authRepository.uploadAvatar(idUser, file);
    if (response.statusCode == 200) {
      state = ProfileState.success;
    } else {
      state = ProfileState.error;
    }
  }
}
