import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends SearchEvent {
  final String token;

  FetchDataEvent(this.token);

  @override
  List<Object> get props => [token];
}
