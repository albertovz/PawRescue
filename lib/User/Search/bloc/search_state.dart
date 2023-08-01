import 'package:equatable/equatable.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Mascota> mascotas;
  final List<Ad> anuncios;

  SearchLoaded(this.mascotas, this.anuncios);

  @override
  List<Object> get props => [mascotas, anuncios];
}

class SearchError extends SearchState {
  final String errorMessage;

  SearchError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
