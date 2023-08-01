import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paw/Pet/Ad/Data/Presentation/AddPetPage.dart';
import 'package:paw/User/Auth/ApiService.dart';

class AdPage extends StatefulWidget {
  String token;
  String userId;

  AdPage(this.token, this.userId);

  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  File? _imageFile;
  bool _hasImage = false;
  String latitud = '', longitud = '';
  String adId = '';
  String token = '';
  String? _titulo;
  String? _tipoAnimal;
  String? _raza;
  String? _sexo;
  DateTime? _fechaIncidente;
  String? _descripcion;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _hasImage = true;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      _hasImage = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final currentDate = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: currentDate,
    );

    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        _fechaIncidente = selectedDate;
      });
    }
  }

  void _addLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Aquí puedes guardar la ubicación en tus variables o realizar cualquier otra acción con ella.
        print("Latitud: ${position.latitude}, Longitud: ${position.longitude}");
        latitud = position.latitude.toString();
        longitud = position.longitude.toString();
        final snackBar = SnackBar(
          content: Text('Dirección agregada exitosamente'),
          backgroundColor:
              Colors.green, // Cambiar el color de fondo del SnackBar
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print("Error al obtener la ubicación: $e");
      }
    } else {
      print("El servicio de ubicación no está habilitado.");
    }
  }

  void _createAd() async {
    if (_titulo == null ||
        _descripcion == null ||
        _fechaIncidente == null ||
        _sexo == null) {
      // Si algún campo obligatorio está vacío, muestra un mensaje de error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Por favor, completa todos los campos obligatorios.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }

    print(_titulo!);
    print(_descripcion!);
    print('$latitud, $longitud');
    print(_fechaIncidente!.toIso8601String());
    print(true);
    print(widget.userId);
    // Datos del anuncio en formato JSON
    final adData = {
      'title': _titulo!,
      'descriptionAd': _descripcion!,
      'ubication': '$latitud, $longitud',
      'datePublication': _fechaIncidente!.toIso8601String(),
      'statusAd': true,
      'catUserId': widget.userId,
    };

    String adIdReturn = await ApiService.createAd(
      widget.token,
      _titulo!,
      _descripcion!,
      '$latitud, $longitud',
      _fechaIncidente!.toIso8601String(),
      true,
      widget.userId,
    );
    adId = adIdReturn;
    print('ID del anuncio creado: $adId');

    // Navegar a la vista AddPetPage y pasar el ID del anuncio como argumento
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 128.0, 16.0,
                  16.0), // Agrega espacio adicional en la parte superior
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16.0), // Radio de esquinas del Card
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Título'),
                          onChanged: (value) {
                            setState(() {
                              _titulo = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Descripción'),
                          onChanged: (value) {
                            setState(() {
                              _descripcion = value;
                            });
                          },
                          maxLines:
                              2, // Para mostrar la descripción en una caja de texto
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: Text(
                            _fechaIncidente != null
                                ? 'Fecha del incidente: ${_fechaIncidente!.toLocal()}'
                                : 'Seleccionar fecha del incidente',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _addLocation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Color de fondo verde
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Radio de esquinas del botón
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.search, size: 24.0), // Ícono de lupa
                              SizedBox(width: 8.0),
                              Text('Agregar ubicación'),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            print(
                                'id del anuncio al presionar siguente: $adId');
                            _createAd();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddPetPage(widget.token, adId, widget.userId),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green, // Color de fondo verde
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: const Text(
                            'Crear anuncio',
                            style: TextStyle(
                              color: Colors.white, // Letras blancas
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
