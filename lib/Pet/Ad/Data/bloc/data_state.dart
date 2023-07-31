import 'package:equatable/equatable.dart';

abstract class AdState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdInitial extends AdState {}

class AdSavingPetData extends AdState {}

class AdPetDataSavedSuccessfully extends AdState {}
