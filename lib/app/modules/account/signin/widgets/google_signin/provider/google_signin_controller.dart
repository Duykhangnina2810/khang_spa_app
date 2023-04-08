import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../authentication/provider/auth_controller.dart';

import '../../../../../authentication/repository/auth_repository.dart';

final googleSignInProvider =
    StateNotifierProvider<GoogleSignInController, GoogleSignInState>(
  (ref) {
    return GoogleSignInController(
        ref.watch(authRepoProvider), ref.read(authProvider.notifier));
  },
);

enum GoogleSignInState {
  initial,
  loading,
  success,
  error,
}

class GoogleSignInController extends StateNotifier<GoogleSignInState> {
  final AuthRepository _authenticationRepository;
  final AuthController _authController;

  GoogleSignInController(this._authenticationRepository, this._authController)
      : super(GoogleSignInState.initial);

  Future<void> signIn() async {
    state = GoogleSignInState.loading;
    final loginUser = await _authenticationRepository.signInWithGoogle();

    // lưu thông tin đăng nhập
    if (loginUser != null) {
      _authController.saveAuth(user: loginUser);
      _authController.onUserChanged(user: loginUser);
      state = GoogleSignInState.success;
    } else {
      state = GoogleSignInState.error;
    }
  }
}
