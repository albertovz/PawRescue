import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewDataPetPage extends StatelessWidget {
  final Mascota mascota;
  final Ad anuncio;

  ViewDataPetPage({required this.mascota, required this.anuncio});

  @override
  Widget build(BuildContext context) {
    List<String> partes = anuncio.ubication.split(", ");
    double latitud = double.parse(partes[0]);
    double longitud = double.parse(partes[1]);
    // print("Latitud: $latitud");
    // print("Longitud: $longitud");
    final LatLng ubicacion = LatLng(latitud, longitud);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Detalles de la Mascota'),
      ),
      body: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mascota.nombre,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                // Mostrar la imagen de la mascota si está disponible
                if (mascota.imagen != null)
                  Image.file(
                    File(
                        "/data/user/0/com.example.paw/cache/${mascota.imagen}"), // Cargar la imagen desde la ruta del archivo
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 16.0),
                Text('Descripción: ${anuncio.descriptionAd}',
                style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 16.0),
                Text('Tipo: ${mascota.tipoAnimal}',
                style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 16.0),
                Text('Raza: ${mascota.raza}',
                style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 16.0),
                Text('Color: ${mascota.color}',
                style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 16.0),
                Text('Género: ${mascota.genero}',
                style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 16.0),
                Text('Edad: ${mascota.edad} años',
                style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 16.0),
                Text('Fecha del incidente: ${anuncio.datePublication}',
                style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 16.0),
                
                const SizedBox(height: 16.0),
                Container(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: ubicacion,
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('Ubicacion'),
                        position: ubicacion,
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
