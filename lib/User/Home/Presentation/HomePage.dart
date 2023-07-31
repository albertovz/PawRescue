import 'package:flutter/material.dart';
import 'package:paw/User/Ad/Presentation/AdPage.dart';
import 'package:paw/User/Login/Presentation/LoginPage.dart';
import 'package:paw/User/Profile/Presentation/ProfilePage.dart';
import 'package:paw/User/Search/Presentation/SearchPage.dart';
import 'package:paw/User/Update/Presentation/UpdatePage.dart';

class HomePage extends StatefulWidget {
  String token;
  String userId;

  HomePage(this.token, this.userId);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _cerrarSesion() {
    widget.token = '';
    widget.userId = '';
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex ==
              1 // Comprobamos si el índice es igual a 1 (ítem "Anunciar" seleccionado)
          ? AdPage(widget.token, widget.userId)
          : _currentIndex ==
                  2 // Comprobamos si el índice es igual a 2 (ítem "Perfil" seleccionado)
              ? ProfilePage(
                  widget.token, widget.userId) // Mostrar la página de Perfil
              : SearchPage(widget.token),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          // No es necesario hacer nada aquí para el ítem "Anunciar" (index == 1),
          // ya que el contenido del body para ese ítem se maneja arriba.
          // Puedes agregar lógica adicional para otros ítems si es necesario.
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Anunciar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
