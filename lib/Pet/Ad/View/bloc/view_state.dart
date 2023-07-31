import 'package:equatable/equatable.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewState extends Equatable {
  final Mascota mascota;
  final Ad anuncio;
  final LatLng ubicacion;

  ViewState({required this.mascota, required this.anuncio, required this.ubicacion});

  @override
  List<Object?> get props => [mascota, anuncio, ubicacion];
}
