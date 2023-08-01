// login_bloc.dart

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw/User/Auth/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailAndPassword) {
      yield* _mapLoginWithEmailAndPasswordToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailAndPasswordToState(
    LoginWithEmailAndPassword event,
  ) async* {
    yield LoginLoading();

    String email = event.email;
    String password = event.password;

    try {
      final response = await ApiService.login(email, password);
      String userId = response['userId'];
      String token = response['token'];

      // Guardar token y userId en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('userId', userId);

      yield LoginSuccess(token, userId);
    } catch (e) {
      print(e);
      yield LoginError('Correo o contraseña incorrecta');
    }
  }

  @override
  Future<void> close() {
    _emailController.dispose();
    _passwordController.dispose();
    return super.close();
  }
}
