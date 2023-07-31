import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:paw/ApiService.dart';
import './login_event.dart';
import './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final response = await ApiService.login(event.email, event.password);
        String userId = response['userId'];
        String token = response['token'];

        yield LoginSuccess(token: token, userId: userId);
      } catch (e) {
        yield LoginFailure();
      }
    }
  }
}
