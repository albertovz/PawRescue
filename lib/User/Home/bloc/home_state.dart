// Importa la librería foundation para usar Equatable.
import 'package:equatable/equatable.dart';

// Define la clase abstracta HomeState que extiende Equatable.
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

// Define los estados que se utilizarán en el BLoC.
class TabChanged extends HomeState {
  final int index;

  TabChanged(this.index);

  @override
  List<Object> get props => [index];
}
