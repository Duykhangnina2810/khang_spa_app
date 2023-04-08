import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/formz/form_models/password_input.dart';
import '../../../../../../utils/formz/form_models/repassword_input.dart';
import '../../../../../../utils/formz/formz.dart';
import '../../../../../authentication/provider/auth_controller.dart';
import '../../../../../authentication/repository/auth_repository.dart';
import '../../../../forgot_password/widgets/forgot_password/provider/forgot_password_controller.dart';

part 'form_reset_password_state.dart';

final formResetPasswordProvider = StateNotifierProvider.autoDispose<
    FormResetPasswordController, FormResetPasswordState>((ref) {
  return FormResetPasswordController(ref);
});

class FormResetPasswordController
    extends StateNotifier<FormResetPasswordState> {
  late final AuthRepository _authenticationRepository;
  late final AuthController _authController;

  final Ref ref;

  FormResetPasswordController(this.ref) : super(FormResetPasswordState()) {
    _authenticationRepository = ref.watch(authRepoProvider);
    _authController = ref.watch(authProvider.notifier);
  }

  void onPasswordChange(String value) {
    final password = PasswordInput.dirty(value);
    state = state.copyWith(
      password: password,
      status: Formz.validate([password, state.rePassword]),
    );
  }

  void onRePasswordChange(String value) {
    final rePassword = RePasswordInput.dirty(value, state.password.value);
    state = state.copyWith(
      rePassword: rePassword,
      status: Formz.validate([state.password, rePassword]),
    );
  }

  void onSubmit() async {
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    final FormzStatus statusForm =
        Formz.validate([state.password, state.rePassword]);
    if (statusForm == FormzStatus.invalid) {
      state = state.copyWith(status: statusForm);
      return;
    }
    Map<String, dynamic> data = {
      "email": ref.watch(forgotPasswordProvider).email.value,
      "password": state.password.value,
    };
    final Response response =
        await _authenticationRepository.forgotPassword(data: data);
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
