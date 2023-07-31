// Importa la librería foundation para usar Equatable.
import 'package:equatable/equatable.dart';

// Define la clase abstracta HomeEvent que extiende Equatable.
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// Define los eventos que se utilizarán en el BLoC.
class ChangeTab extends HomeEvent {
  final int index;

  ChangeTab(this.index);

  @override
  List<Object> get props => [index];
}
