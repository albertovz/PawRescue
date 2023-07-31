import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paw/ApiService.dart';
import 'package:paw/User/Login/Presentation/LoginPage.dart';
import 'dart:convert';
import 'package:paw/main.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Registro de Usuario',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const RegisterPage(),
//     );
//   }
// }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _secondLastNameController = TextEditingController();
  final _sexController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _facebookController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedGender = 'Masculino';

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro exitoso'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Implementar la lógica de registro aquí
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String secondLastName = _secondLastNameController.text;
      String sex = _sexController.text;
      String address = _addressController.text;
      String city = _cityController.text;
      String state = _stateController.text;
      String phone = _phoneController.text;
      String facebookLink = _facebookController.text;
      String description = _descriptionController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la clave del Scaffold
      appBar: AppBar(
        title: Text('Registro de Usuario'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _secondLastNameController,
                decoration: InputDecoration(labelText: 'Segundo Apellido'),
              ),
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
                decoration: InputDecoration(labelText: 'Sexo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona tu género';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Ciudad'),
              ),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'Estado'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Teléfono'),
              ),
              TextFormField(
                controller: _facebookController,
                decoration: InputDecoration(labelText: 'Link de Facebook'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu email';
                  }
                  // Validar que el email tenga un formato válido
                  if (!value.contains('@')) {
                    return 'Ingresa un email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  // Agregar otras reglas de validación de contraseña si es necesario
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String firstName = _firstNameController.text;
                  String lastName = _lastNameController.text;
                  String secondLastName = _secondLastNameController.text;
                  String sex = _selectedGender;
                  String address = _addressController.text;
                  String city = _cityController.text;
                  String state = _stateController.text;
                  String phone = _phoneController.text;
                  String facebookLink = _facebookController.text;
                  String description = _descriptionController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  // Construir el cuerpo de la solicitud
                  Map<String, dynamic> data = {
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
                    'email': email,
                    'password': password,
                  };

                  // Hacer la solicitud POST al backend de React
                  ApiService.registerUser(data).then((_) {
                    _showSuccessSnackBar(context);

                    // Use Navigator.pushReplacement to prevent going back to the RegisterPage
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginPage(), // Replace with your main view class (main.dart)
                        ),
                      );
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text('Registrar', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
