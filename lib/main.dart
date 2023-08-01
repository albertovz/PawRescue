import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paw/User/Home/Presentation/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paw/User/Login/Presentation/LoginPage.dart';

import './User/Search/bloc/search_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future:
              _checkLoginStatus(), // Verificar el estado del inicio de sesión
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Muestra una pantalla de carga mientras se verifica el estado del inicio de sesión
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Dependiendo del estado del inicio de sesión, muestra la página de inicio de sesión o la página de inicio
              if (snapshot.data == true) {
                return HomePageWithData();
              } else {
                return LoginPage();
              }
            }
          },
        ),
      ),
    );
  }

  // Función para verificar si hay un token guardado en SharedPreferences
  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }
}

class HomePageWithData extends StatefulWidget {
  @override
  State<HomePageWithData> createState() => _HomePageWithDataState();
}

class _HomePageWithDataState extends State<HomePageWithData> {
  String? _token;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _userId = prefs.getString('userId');
    setState(() {}); // Actualizar el estado después de obtener los valores
  }

  @override
  Widget build(BuildContext context) {
    if (_token != null && _userId != null) {
      return HomePage(_token!, _userId!);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
