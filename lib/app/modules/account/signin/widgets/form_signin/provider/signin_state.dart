part of 'signin_controller.dart';

class SignInState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final FormzStatus status;
  final String? errorMessage;

  const SignInState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = '',
  });

  SignInState copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status, errorMessage!];
}
