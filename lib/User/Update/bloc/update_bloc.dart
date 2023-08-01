import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw/User/Auth/ApiService.dart';

import 'update_event.dart';
import 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitialState());

  @override
  Stream<UpdateState> mapEventToState(UpdateEvent event) async* {
    if (event is UpdateUserProfileEvent) {
      yield UpdateLoadingState();

      try {
        var data;
        var token;
        bool isSuccess = await ApiService.updateUserProfile(data, token);
        if (isSuccess) {
          yield UpdateSuccessState();
        } else {
          yield UpdateErrorState('Failed to update user profile.');
        }
      } catch (e) {
        yield UpdateErrorState('An error occurred: $e');
      }
    }
  }
}
