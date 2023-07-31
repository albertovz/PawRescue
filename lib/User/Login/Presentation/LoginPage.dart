import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:paw/ApiService.dart';
import 'package:paw/User/Home/Presentation/HomePage.dart';
import '../../Register/Presentation/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String token = '';
  String userId = '';

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      final response = await ApiService.login(email, password);
      String userId = response['userId'];
      String token = response['token'];

      final snackBar = SnackBar(
        content: Text('Bienvenido de nuevo usuario'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(token, userId),
        ),
      );
      
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text('Correo o contraseña incorrecta'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _register() {
    // Implement your registration logic here
    String email = _emailController.text;
    String password = _passwordController.text;
    // Do something with the email and password (e.g., send them to the server to create a new account)
    print('Register - Email: $email\nPassword: $password');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de pantalla (Imagen estática)
          Image.asset(
            'assets/images/login_bg.png', // Cambia esta ruta con la ubicación de tu imagen estática
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black
                  .withOpacity(0.3), // Ajusta la opacidad según tu preferencia
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width:
                    300, // Ajusta el tamaño de la imagen según tus necesidades
                height: 300,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 450.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD99F72),
                      fixedSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _register,
                    child: const Text(
                      '¿No tienes cuenta? Registrarse',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
