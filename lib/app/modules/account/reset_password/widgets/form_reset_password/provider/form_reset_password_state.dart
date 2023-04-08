part of 'form_reset_password_controller.dart';

class FormResetPasswordState extends Equatable {
  final PasswordInput password;
  final RePasswordInput rePassword;
  final FormzStatus status;
  final String? errorMessage;

  const FormResetPasswordState({
    this.password = const PasswordInput.pure(),
    this.rePassword = const RePasswordInput.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = '',
  });

  FormResetPasswordState copyWith({
    PasswordInput? password,
    RePasswordInput? rePassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return FormResetPasswordState(
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [password, rePassword, status, errorMessage!];
}
