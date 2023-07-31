import 'package:flutter/material.dart';
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:paw/ApiService.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';
import 'package:paw/Pet/Ad/View/Presentation/ViewDataPetPage.dart';

class SearchPage extends StatefulWidget {
  String token;

  SearchPage(this.token);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Mascota> mascotas = []; // Lista de mascotas
  List<Ad> anuncios = []; // Lista de mascotas

  @override
  void initState() {
    super.initState();
    // Realizar la solicitud HTTP cuando se inicia el widget
    _fetchDataPet();
    _fetchDataAd();
  }

  Future<void> _fetchDataPet() async {
    try {
      // Llamar a la función en ApiService para obtener las mascotas
      final mascotasData = await ApiService.fetchDataPet(widget.token);
      setState(() {
        mascotas = mascotasData;
      });
    } catch (e) {
      print('Error en la solicitud de mascotas: $e');
    }
  }

  Future<void> _fetchDataAd() async {
    try {
      final List<Ad> fetchedAnuncios = await ApiService.fetchDataAd(widget.token);
      setState(() {
        anuncios = fetchedAnuncios;
      });
    } catch (e) {
      // Si ocurre una excepción, manejarla aquí
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Lista de Mascotas'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: anuncios.isNotEmpty
            ? ListView.builder(
                itemCount: anuncios.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 4.0,
                    margin: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                anuncios[index].title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  'Descripción: ${anuncios[index].descriptionAd}'),
                              Text(
                                  'Fecha del incidente: ${anuncios[index].datePublication}'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewDataPetPage(
                                        mascota: mascotas[index],
                                        anuncio: anuncios[index],
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .red, // Establecer el color rojo aquí
                                ),
                                child: const Text('Ver datos de mascota'),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: anuncios[index].statusAd
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              anuncios[index].statusAd
                                  ? 'Activa'
                                  : 'Encontrado',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
