part of 'forgot_password_controller.dart';

class ForgotPasswordState extends Equatable {
  final EmailInput email;
  final String pinCode;
  final int timeEnd;
  final FormzStatus status;
  final String? errorMessage;

  const ForgotPasswordState({
    this.email = const EmailInput.pure(),
    this.status = FormzStatus.pure,
    this.pinCode = '',
    this.timeEnd = 0,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    EmailInput? email,
    String? pinCode,
    int? timeEnd,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      pinCode: pinCode ?? this.pinCode,
      timeEnd: timeEnd ?? this.timeEnd,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        email,
        pinCode,
        timeEnd,
        status,
      ];
}
