import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'view_event.dart';
import 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  ViewBloc({required this.mascota, required this.anuncio}) : super(ViewState(mascota: mascota, anuncio: anuncio, ubicacion: _getUbicacion(anuncio.ubication)));

  final Mascota mascota;
  final Ad anuncio;

  @override
  Stream<ViewState> mapEventToState(
    ViewEvent event,
  ) async* {
    if (event is LoadViewDataEvent) {
      yield ViewState(mascota: mascota, anuncio: anuncio, ubicacion: _getUbicacion(anuncio.ubication));
    }
  }

  static LatLng _getUbicacion(String ubicacionString) {
    List<String> partes = ubicacionString.split(", ");
    double latitud = double.parse(partes[0]);
    double longitud = double.parse(partes[1]);
    return LatLng(latitud, longitud);
  }
}
