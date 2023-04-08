part of 'signup_controller.dart';

class SignUpState extends Equatable {
  final TextInput fullName;
  final TextInput phone;
  final EmailInput email;
  final PasswordInput password;
  final RePasswordInput rePassword;
  final String? gender;
  final String? birthDay;
  final FormzStatus status;
  final String? errorMessage;

  const SignUpState({
    this.fullName = const TextInput.pure(),
    this.phone = const TextInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.rePassword = const RePasswordInput.pure(),
    this.gender = '',
    this.birthDay = '',
    this.status = FormzStatus.pure,
    this.errorMessage = '',
  });

  SignUpState copyWith({
    TextInput? fullName,
    TextInput? phone,
    EmailInput? email,
    PasswordInput? password,
    RePasswordInput? rePassword,
    String? gender,
    String? birthDay,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        phone,
        email,
        password,
        rePassword,
        gender!,
        birthDay!,
        status,
        errorMessage!
      ];
}
