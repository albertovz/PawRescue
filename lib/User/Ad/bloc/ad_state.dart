part of 'ad_bloc.dart';

@immutable
abstract class AdState {}

class AdInitial extends AdState {}

class AdSuccessState extends AdState {
  final String adId;

  AdSuccessState({required this.adId});
}

class AdErrorState extends AdState {
  final String errorMessage;

  AdErrorState({required this.errorMessage});
}
