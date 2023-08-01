import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:paw/User/Auth/ApiService.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';
import 'package:paw/User/Search/bloc/search_event.dart';
import 'package:paw/User/Search/bloc/search_state.dart';
import '../bloc/search_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is FetchDataEvent) {
      yield* _mapFetchDataEventToState(event.token);
    }
  }

  Stream<SearchState> _mapFetchDataEventToState(String token) async* {
    yield SearchLoading();
    try {
      final mascotasData = await ApiService.fetchDataPet(token);
      final List<Ad> fetchedAnuncios = await ApiService.fetchDataAd(token);
      yield SearchLoaded(mascotasData, fetchedAnuncios);
    } catch (e) {
      yield SearchError('Error en la solicitud de datos: $e');
    }
  }
}
