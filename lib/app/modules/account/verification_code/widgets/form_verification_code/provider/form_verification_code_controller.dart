import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../utils/formz/form_models/text_input.dart';
import '../../../../../../utils/formz/formz.dart';
import '../../../../../authentication/repository/auth_repository.dart';
import '../../../../forgot_password/widgets/forgot_password/provider/forgot_password_controller.dart';

part 'form_verification_code_state.dart';

final formVerificationCodeProvider = StateNotifierProvider<
    FormVerificationCodeController, FormVerificationCodeState>(
  (ref) {
    return FormVerificationCodeController(ref);
  },
);

class FormVerificationCodeController
    extends StateNotifier<FormVerificationCodeState> {
  late final AuthRepository _authenticationRepository;
  late final ForgotPasswordState _forgotPasswordState;
  final Ref ref;

  FormVerificationCodeController(this.ref)
      : super(const FormVerificationCodeState()) {
    init();
  }

  init() {
    _authenticationRepository = ref.watch(authRepoProvider);
    _forgotPasswordState = ref.watch(forgotPasswordProvider);
  }

  ForgotPasswordState get forgotPasswordState => _forgotPasswordState;

  void onPinCodeChange(String value) {
    final pinCode = TextInput.dirty(value);
    state = state.copyWith(
      pinCode: pinCode,
      status: Formz.validate([pinCode]),
    );
  }

  Future<void> submitFormVerificationCode() async {
    if (!state.status.isValidated) return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_forgotPasswordState.timeEnd >= now) {
      if (state.pinCode.value == _forgotPasswordState.pinCode) {
        state = state.copyWith(status: FormzStatus.submissionSuccess);
      } else {
        state = state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage:
                'Mã xác thực không đúng. Vui lòng kiểm tra lại mã xác thực.');
      }
    } else {
      state = state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage:
              'Thời gian hiệu lực của mã xác thực đã hết. Vui lòng nhận lại mã xác thức mới bằng cách bấm vào dòng chữ bên dưới. Cảm ơn.');
    }
  }

  Future<void> reSendVerificationCode() async {
    state = state.copyWith(reSendStatus: ReSendStatus.loading);
    try {
      final Response response = await _authenticationRepository
          .sendCodePassword(email: _forgotPasswordState.email.value);
      if (response.statusCode == 200) {
        final result = response.data;
        if (result['success'] == true) {
          state = state.copyWith(reSendStatus: ReSendStatus.sended);
          ref.read(forgotPasswordProvider.notifier).updateNewState(
              newState: _forgotPasswordState.copyWith(
                  pinCode: result['data']['code'],
                  timeEnd: result['data']['timeEnd']));
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
}
