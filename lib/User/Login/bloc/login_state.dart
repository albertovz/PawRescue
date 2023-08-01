// login_state.dart

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final String userId;

  LoginSuccess(this.token, this.userId);
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError(this.errorMessage);
}
