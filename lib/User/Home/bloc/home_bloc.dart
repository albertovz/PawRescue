import 'package:bloc/bloc.dart';
import 'package:paw/User/Home/bloc/home_event.dart';
import 'package:paw/User/Home/bloc/home_state.dart';

// Define la clase HomeBloc que extiende Bloc y toma eventos HomeEvent y emite estados HomeState.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState);
  
}
