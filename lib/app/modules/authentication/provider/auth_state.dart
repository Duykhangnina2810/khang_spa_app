part of 'auth_controller.dart';

enum AuthStatus {
  loading,
  authenticated,
  unauthenticated,
  authFailure,
  anonymous,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final AuthUserModel? authUserModel;
  final String? mess;

  const AuthState({
    required this.authStatus,
    this.authUserModel,
    this.mess,
  });

  AuthState copyWith(
      {AuthStatus? authStatus, AuthUserModel? authUserModel, String? mess}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      authUserModel: authUserModel ?? this.authUserModel,
      mess: mess ?? this.mess,
    );
  }

  @override
  List<Object> get props => [authStatus, authUserModel!, mess!];
}
