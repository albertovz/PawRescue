import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:paw/User/Ad/bloc/ad_bloc.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  AdBloc() : super(AdInitial());

  @override
  Stream<AdState> mapEventToState(AdEvent event) async* {
    
  }
}
