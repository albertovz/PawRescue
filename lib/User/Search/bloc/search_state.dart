import 'package:equatable/equatable.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Ad> anuncios;
  final List<Mascota> mascotas;

  SearchLoadedState(this.anuncios, this.mascotas);

  @override
  List<Object> get props => [anuncios, mascotas];
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}
