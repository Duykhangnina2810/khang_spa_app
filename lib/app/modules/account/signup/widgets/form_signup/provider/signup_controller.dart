import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/formz/form_models/email_input.dart';
import '../../../../../../utils/formz/form_models/password_input.dart';
import '../../../../../../utils/formz/form_models/repassword_input.dart';
import '../../../../../../utils/formz/form_models/text_input.dart';
import '../../../../../../utils/formz/formz.dart';
import '../../../../../authentication/provider/auth_controller.dart';
import '../../../../../authentication/repository/auth_repository.dart';

part 'signup_state.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>((ref) {
  return SignUpController(ref);
});

class SignUpController extends StateNotifier<SignUpState> {
  late final AuthRepository _authenticationRepository;
  late final AuthController _authController;

  final Ref ref;

  SignUpController(this.ref) : super(SignUpState()) {
    _authenticationRepository = ref.watch(authRepoProvider);
    _authController = ref.watch(authProvider.notifier);
  }

  void onFullNameChange(String value) {
    final fullName = TextInput.dirty(value);
    state = state.copyWith(
      fullName: fullName,
      status: Formz.validate(
          [fullName, state.email, state.password, state.rePassword]),
    );
  }

  void onEmailChange(String value) {
    final email = EmailInput.dirty(value);
    state = state.copyWith(
      email: email,
      status: Formz.validate(
          [state.fullName, email, state.password, state.rePassword]),
    );
  }

  void onPasswordChange(String value) {
    final password = PasswordInput.dirty(value);
    state = state.copyWith(
      password: password,
      status: Formz.validate(
          [state.fullName, state.email, password, state.rePassword]),
    );
  }

  void onRePasswordChange(String value) {
    final rePassword = RePasswordInput.dirty(value, state.password.value);
    state = state.copyWith(
      rePassword: rePassword,
      status: Formz.validate(
          [state.fullName, state.email, state.password, rePassword]),
    );
  }

  void onSignUp() async {
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    final FormzStatus statusForm = Formz.validate(
        [state.fullName, state.email, state.password, state.rePassword]);
    if (statusForm == FormzStatus.invalid) {
      state = state.copyWith(status: statusForm);
      return;
    }
    Map<dynamic, dynamic> data = {
      "fullname": state.fullName.value,
      "email": state.email.value,
      "password": state.password.value,
    };
    final Response response =
        await _authenticationRepository.signUp(data: data);
    if (response.statusCode == 200) {
      final result = response.data;
      if (result['success'] == true) {
        state = state.copyWith(status: FormzStatus.submissionSuccess);
      } else {
        state = state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: result['message']);
      }
    } else {
      state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: response.statusMessage);
    }
  }
}
