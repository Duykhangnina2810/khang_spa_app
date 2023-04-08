part of 'form_verification_code_controller.dart';

enum ReSendStatus { pure, loading, sended }

class FormVerificationCodeState extends Equatable {
  final TextInput pinCode;
  final FormzStatus status;
  final ReSendStatus reSendStatus;
  final String? errorMessage;

  const FormVerificationCodeState({
    this.pinCode = const TextInput.pure(),
    this.status = FormzStatus.pure,
    this.reSendStatus = ReSendStatus.pure,
    this.errorMessage,
  });

  FormVerificationCodeState copyWith({
    TextInput? pinCode,
    FormzStatus? status,
    ReSendStatus? reSendStatus,
    String? errorMessage,
  }) {
    return FormVerificationCodeState(
      pinCode: pinCode ?? this.pinCode,
      status: status ?? this.status,
      reSendStatus: reSendStatus ?? this.reSendStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [pinCode, status, reSendStatus];
}
