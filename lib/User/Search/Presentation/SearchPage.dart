import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw/Pet/Ad/View/Presentation/ViewDataPetPage.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class SearchPage extends StatefulWidget {
  final String token;

  SearchPage(this.token);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    // Iniciar la búsqueda de datos al cargar el widget
    BlocProvider.of<SearchBloc>(context).add(FetchDataEvent(widget.token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Lista de Mascotas'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoaded) {
            return ListView.builder(
              itemCount: state.anuncios.length,
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
                              state.anuncios[index].title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                                'Descripción: ${state.anuncios[index].descriptionAd}'),
                            Text(
                                'Fecha del incidente: ${state.anuncios[index].datePublication}'),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewDataPetPage(
                                      mascota: state.mascotas[index],
                                      anuncio: state.anuncios[index],
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
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
                            color: state.anuncios[index].statusAd
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            state.anuncios[index].statusAd
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
            );
          } else if (state is SearchError) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            return Container(); // Estado inicial o cualquier otro estado
          }
        },
      ),
    );
  }
}
