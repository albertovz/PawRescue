import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:paw/ApiService.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchDataPet) {
      yield* _mapFetchDataPetToState(event);
    } else if (event is FetchDataAd) {
      yield* _mapFetchDataAdToState(event);
    }
  }

  Stream<SearchState> _mapFetchDataPetToState(FetchDataPet event) async* {
    yield SearchLoadingState();

    try {
      final mascotasData = await ApiService.fetchDataPet(event.token);
      yield SearchLoadedState([], mascotasData);
    } catch (e) {
      yield SearchErrorState('Error en la solicitud de mascotas: $e');
    }
  }

  Stream<SearchState> _mapFetchDataAdToState(FetchDataAd event) async* {
    yield SearchLoadingState();

    try {
      final fetchedAnuncios = await ApiService.fetchDataAd(event.token);
      yield SearchLoadedState(fetchedAnuncios, []);
    } catch (e) {
      yield SearchErrorState('Error: $e');
    }
  }
}
