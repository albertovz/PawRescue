import 'package:flutter/material.dart';
import 'package:paw/ApiService.dart';
import 'package:paw/User/Home/Presentation/HomePage.dart';
import 'dart:async';

import 'package:paw/User/Profile/Presentation/ProfilePage.dart';

class UpdatePage extends StatefulWidget {
  String token;
  String userId;

  UpdatePage(this.token, this.userId);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _secondLastNameController =
      TextEditingController();
  final TextEditingController _directionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Map<String, dynamic>? _userProfile;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedGender = '';

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos actualizados con éxito'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _getUserProfile() async {
    try {
      final userProfile =
          await ApiService.getUserProfile(widget.token, widget.userId);
      setState(() {
        _userProfile = userProfile;
        _selectedGender = '${_userProfile!['sex']}';
      });
    } catch (e) {
      // Ocurrió un error en la conexión o la solicitud
      print('Error en la conexión: $e');
    }

    // _selectedGender = '${_userProfile!['sex']}';
    print('id del usuario: ${_userProfile!['imgProfile']}');
  }

  Future<void> _updateUserProfile() async {
    // print('Path antes: ${_userProfile!['imgProfile']}');
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String secondLastName = _secondLastNameController.text;
    String sex = _selectedGender;
    String address = _directionController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String phone = _phoneController.text;
    String facebookLink = _facebookController.text;
    String description = _descriptionController.text;
    String email = _emailController.text;

    Map<String, dynamic> data = {
      'id': '${_userProfile!['id']}',
      'imgProfile': '${_userProfile!['imgProfile']}',
      'name': firstName,
      'lastName': lastName,
      'secondSurname': secondLastName,
      'sex': sex,
      'direction': address,
      'city': city,
      'state': state,
      'phone': phone,
      'linkfb': facebookLink,
      'descriptionUser': description,
      'email': email
    };

    bool isSuccess = await ApiService.updateUserProfile(widget.token, data);
    print('booleano: $isSuccess');

    if (isSuccess) {
      // La solicitud fue exitosa, puedes realizar acciones en respuesta a esto
      print('Datos actualizados exitosamente');

      _showSuccessSnackBar(_scaffoldKey.currentContext!);

      // Esperamos 3 segundos antes de redirigir a la vista "ProfilePage"
      await Future.delayed(Duration(seconds: 3));

      // Redirigimos a la vista "ProfilePage" y refrescamos los datos
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(widget.token, widget.userId),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      // Resto del código...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              // Campo para el nombre
              TextFormField(
                controller: _firstNameController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['name']}'),
              ),

              // Campo para el apellido
              TextFormField(
                controller: _lastNameController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['lastName']}'),
              ),

              // Campo para el segundo apellido
              TextFormField(
                controller: _secondLastNameController,
                decoration: InputDecoration(
                    labelText: '${_userProfile!['secondSurname']}'),
              ),

              // Campo para el sexo
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: ['Masculino', 'Femenino'].map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Sexo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona tu género';
                  }
                  return null;
                },
              ),

              // Campo para la dirección
              TextFormField(
                controller: _directionController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['direction']}'),
              ),

              // Campo para el estado
              TextFormField(
                controller: _stateController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['state']}'),
              ),

              // Campo para la ciudad
              TextFormField(
                controller: _cityController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['city']}'),
              ),

              // Campo para el teléfono
              TextFormField(
                controller: _phoneController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['phone']}'),
              ),

              // Campo para la descripción
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    labelText: '${_userProfile!['descriptionUser']}'),
              ),

              // Campo para el enlace de Facebook
              TextFormField(
                controller: _facebookController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['linkfb']}'),
              ),

              // Campo para el correo
              TextFormField(
                controller: _emailController,
                decoration:
                    InputDecoration(labelText: '${_userProfile!['email']}'),
              ),

              // Botón para actualizar los datos
              ElevatedButton(
                onPressed: _updateUserProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
