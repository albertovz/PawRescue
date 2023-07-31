import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPet extends SearchEvent {
  final String token;

  FetchDataPet(this.token);

  @override
  List<Object> get props => [token];
}

class FetchDataAd extends SearchEvent {
  final String token;

  FetchDataAd(this.token);

  @override
  List<Object> get props => [token];
}
