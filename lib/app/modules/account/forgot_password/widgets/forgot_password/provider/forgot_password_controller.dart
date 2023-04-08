import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../utils/formz/form_models/email_input.dart';
import '../../../../../../utils/formz/formz.dart';
import '../../../../../authentication/repository/auth_repository.dart';

part 'forgot_password_state.dart';

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordState>(
  (ref) => ForgotPasswordController(
    ref.watch(authRepoProvider),
  ),
);

class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final AuthRepository _authenticationRepository;

  ForgotPasswordController(this._authenticationRepository)
      : super(const ForgotPasswordState());

  void onEmailChange(String value) {
    final email = EmailInput.dirty(value);
    state = state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Future<void> forgotPassword() async {
    if (!state.status.isValidated) return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      final Response response = await _authenticationRepository
          .sendCodePassword(email: state.email.value);
      if (response.statusCode == 200) {
        final result = response.data;
        if (result['success'] == true) {
          state = state.copyWith(
              status: FormzStatus.submissionSuccess,
              pinCode: result['data']['code'],
              timeEnd: result['data']['timeEnd']);
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
    } catch (e) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString());
    }
  }

  updateNewState({required ForgotPasswordState newState}) async {
    state = newState;
  }
}
