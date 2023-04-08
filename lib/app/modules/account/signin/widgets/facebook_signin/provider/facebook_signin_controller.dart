import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../authentication/provider/auth_controller.dart';

import '../../../../../authentication/repository/auth_repository.dart';

final facebookSignInProvider =
    StateNotifierProvider<FacebookSignInController, FacebookSignInState>(
  (ref) {
    return FacebookSignInController(
        ref.watch(authRepoProvider), ref.read(authProvider.notifier));
  },
);

enum FacebookSignInState {
  initial,
  loading,
  success,
  error,
}

class FacebookSignInController extends StateNotifier<FacebookSignInState> {
  final AuthRepository _authenticationRepository;
  final AuthController _authController;

  FacebookSignInController(this._authenticationRepository, this._authController)
      : super(FacebookSignInState.initial);

  Future<void> signIn() async {
    state = FacebookSignInState.loading;
    try {
      final loginUser = await _authenticationRepository.signInWithFacebook();
      // lưu thông tin đăng nhập
      if (loginUser != null) {
        _authController.saveAuth(user: loginUser);
        _authController.onUserChanged(user: loginUser);
      }
      state = FacebookSignInState.success;
    } catch (e) {
      state = FacebookSignInState.error;
    }
  }
}
