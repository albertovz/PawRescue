import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final String userId;

  LoginSuccess({required this.token, required this.userId});

  @override
  List<Object> get props => [token, userId];
}

class LoginFailure extends LoginState {}
