part of 'ad_bloc.dart';

@immutable
abstract class AdEvent {}

class CreateAdEvent extends AdEvent {
  // Aquí puedes agregar propiedades para los datos del formulario que necesitas para crear el anuncio
  final String titulo;
  final String descripcion;
  // Otras propiedades necesarias

  CreateAdEvent({
    required this.titulo,
    required this.descripcion,
    // Inicializa otras propiedades aquí si es necesario
  });
}
