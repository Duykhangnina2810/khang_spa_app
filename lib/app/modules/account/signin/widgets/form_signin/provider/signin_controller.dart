import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../../../constants/app_settings.dart';
import '../../../../../../core/nd_app.dart';
import '../../../../../../utils/formz/form_models/email_input.dart';
import '../../../../../../utils/formz/form_models/password_input.dart';
import '../../../../../../utils/formz/formz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../authentication/provider/auth_controller.dart';
import '../../../../../authentication/repository/auth_repository.dart';

part 'signin_state.dart';

final signInProvider =
    StateNotifierProvider.autoDispose<SignInController, SignInState>((ref) {
  return SignInController(ref);
});

class SignInController extends StateNotifier<SignInState> {
  late final AuthRepository _authenticationRepository;
  late final AuthController _authController;
  late final Box _boxAuth;

  final Ref ref;

  SignInController(this.ref) : super(SignInState()) {
    init();
  }

  init() async {
    _authenticationRepository = ref.watch(authRepoProvider);
    _authController = ref.watch(authProvider.notifier);
    _boxAuth = await NdApp.localStorage.openBox(AppSettings.boxAuth);
  }

  void onEmailChange(String value) {
    final email = EmailInput.dirty(value);
    state = state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    );
  }

  void onPasswordChange(String value) {
    final password = PasswordInput.dirty(value);
    state = state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    );
  }

  void signIn() async {
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    if (Formz.validate([state.email, state.password]) == FormzStatus.invalid) {
      state =
          state.copyWith(status: Formz.validate([state.email, state.password]));
      return;
    }
    try {
      final response = await _authenticationRepository.signIn(
          data: {"email": state.email.value, "password": state.password.value});

      if (response.statusCode == 200) {
        final result = response.data;
        if (result['success'] == true) {
          _authenticationRepository.saveToken(result);

          final loginUser = await _authenticationRepository.getCurrentUserById(
              id: result['id']);

          if (loginUser != null) {
            _authController.onUserChanged(user: loginUser);
            state = state.copyWith(status: FormzStatus.submissionSuccess);
          } else {
            state = state.copyWith(
                status: FormzStatus.submissionFailure,
                errorMessage: result['message']);
          }
        } else {
          state = state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: result['message'],
          );
        }
      } else {
        state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: response.statusMessage,
        );
      }
    } catch (e) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString());
    }
  }
}
