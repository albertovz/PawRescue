import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:paw/User/Ad/Presentation/AdPage.dart';
import 'package:paw/User/Auth/ApiService.dart';
import 'package:paw/User/Home/Presentation/HomePage.dart';

class AddPetPage extends StatefulWidget {
  String adId;
  String token;
  String userId;

  AddPetPage(this.token, this.adId, this.userId);

  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  TextEditingController _petNameController = TextEditingController();
  TextEditingController _breedController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String _selectedAnimalType =
      'Perro'; // Default value for DropdownButtonFormField
  String _selectedGender =
      'Hembra'; // Default value for DropdownButtonFormField
  String? _nombre;
  String? _tipoAnimal;
  String? _raza;
  String? _color;
  String? _genero;
  int? _edad;
  File? _imageFile;
  bool _hasImage = false;

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

  @override
  void initState() {
    super.initState();
    print('id del anuncio creado...: ${widget.adId}');
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      _hasImage = false;
    });
  }

  Future<void> _savePetData() async {
    final edadString = _edad?.toString() ?? '0';
    // Prepare the data to be sent in the request body
    print('catAdId: ${widget.adId}');
    final petData = {
      // 'imgPet': _imageFile.toString(),
      'name': _petNameController.text,
      'type': _selectedAnimalType,
      'race': _breedController.text,
      'color': _colorController.text,
      'gender': _selectedGender,
      'age': edadString,
      'catAdId': widget.adId.toString(),
    };
    print(_petNameController.text);
    print(_selectedAnimalType);
    print(_breedController.text);
    print(_colorController.text);
    print(_selectedGender);
    print(_edad);
    print(widget.adId);
    print(_imageFile);

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiService.baseUrl}/pet/create'),
    );

    // Agregar la imagen al cuerpo de la solicitud
    if (_imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'imgPet', // Nombre del campo para la imagen en el servidor
          _imageFile!.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    // Agregar los datos de la mascota al cuerpo de la solicitud
    request.fields.addAll(petData);

    // Agregar el token en el encabezado de la solicitud
    request.headers['auth-token'] = widget.token;

    // Enviar la solicitud
    final response = await request.send();

    if (response.statusCode == 200) {
      // Pet data saved successfully
      // You can handle the response here if needed
      print('Pet data saved successfully');
      final snackBar = SnackBar(
        content: Text('Mascota creada exitosamente'),
        backgroundColor: Colors.green, // Cambiar el color de fondo del SnackBar
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(widget.token, widget.userId), // Reemplaza 'HomePage()' por el constructor correcto de la clase HomePage
        ),
      );
    } else {
      // Error in the request
      // You can handle the error here if needed
      print('Error saving pet data: ${response.statusCode}');
      final snackBar = SnackBar(
        content: Text('Error al crear la mascota'),
        backgroundColor: Colors.red, // Cambiar el color de fondo del SnackBar
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Mascota'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              elevation: 4.0,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.0),
                    Text(
                      'Agregar foto',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _hasImage
                        ? Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.file(_imageFile!,
                                  width: 150, height: 150, fit: BoxFit.cover),
                              IconButton(
                                onPressed: _removeImage,
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          )
                        : IconButton(
                            onPressed: _openCamera,
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 48.0,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            // Nuevo card agregado al inicio del original
            Card(
              elevation: 4.0,
              color: Colors.white,
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Completa los datos de tu mascota',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _petNameController,
                      decoration: const InputDecoration(
                          labelText: 'Nombre de la mascota'),
                      onChanged: (value) {
                        setState(() {
                          _nombre = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Tipo de animal'),
                      value: _tipoAnimal,
                      onChanged: (value) {
                        setState(() {
                          _tipoAnimal = value;
                        });
                      },
                      items: ['Perro', 'Gato', 'Otro'].map((animal) {
                        return DropdownMenuItem(
                          value: animal,
                          child: Text(animal),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _breedController,
                      decoration: const InputDecoration(labelText: 'Raza'),
                      onChanged: (value) {
                        setState(() {
                          _raza = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _colorController,
                      decoration: const InputDecoration(labelText: 'Color'),
                      onChanged: (value) {
                        setState(() {
                          _color = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Género'),
                      value: _genero,
                      onChanged: (value) {
                        setState(() {
                          _genero = value;
                        });
                      },
                      items: ['Hembra', 'Macho'].map((genero) {
                        return DropdownMenuItem(
                          value: genero,
                          child: Text(genero),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Edad'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _edad = int.tryParse(value);
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        print(
                            'id del anuncio dentro de la vista crear mascota: ${widget.adId}');
                        _savePetData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Change the color to red
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
