import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:paw/ApiService.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState(null));

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchUserProfile) {
      try {
        var token;
        var userId;
        final userProfile = await ApiService.getUserProfile(token, userId);
        yield ProfileState(userProfile);
      } catch (e) {
        // Ocurrió un error en la conexión o la solicitud
        print('Error en la conexión: $e');
        yield state; // Mantener el estado actual en caso de error
      }
    }
  }
}
