import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paw/ApiService.dart';
import 'package:paw/User/Login/Presentation/LoginPage.dart';
import 'package:paw/User/Update/Presentation/UpdatePage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  String token;
  String userId;

  ProfilePage(this.token, this.userId);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _userProfile;
  Uri _url = Uri.parse('');

  Future<void> _getUserProfile() async {
    print('Token desde perfil: ${widget.token}');
    print('Id del usuario desde perfil: ${widget.userId}');
    try {
      final userProfile =
          await ApiService.getUserProfile(widget.token, widget.userId);
      setState(() {
        _userProfile = userProfile;
      });
    } catch (e) {
      // Ocurrió un error en la conexión o la solicitud
      print('Error en la conexión: $e');
    }
  }

  void _cerrarSesion() {
    // Aquí puedes agregar la lógica para cerrar la sesión, por ejemplo, limpiar el token de autenticación o realizar cualquier otra acción necesaria.
    // Luego, redirige al usuario a la página de LoginPage.
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Método para navegar a la vista de edición
  void _editarPerfil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePage(widget.token, widget.userId),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user profile when the ProfilePage is initialized
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return _userProfile != null
        ? Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/design.png'), // Ruta de la imagen de fondo
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ListView(
                  padding: const EdgeInsets.only(
                      top: 130, left: 64, right: 64, bottom: 64),
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/images/${_userProfile!['imgProfile']}',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${_userProfile!['name']} ${_userProfile!['lastName']} ${_userProfile!['secondSurname']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${_userProfile!['descriptionUser']}'),
                                SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    _url = Uri.parse(
                                        'https://${_userProfile!['linkfb']}');
                                    _launchUrl();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  icon: const Icon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.white,
                                  ),
                                  label: const Text('Seguir'),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: _editarPerfil,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dirección: ${_userProfile!['direction']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('Teléfono: ${_userProfile!['phone']}'),
                            SizedBox(height: 8),
                            Text('Estado: ${_userProfile!['state']}'),
                            SizedBox(height: 8),
                            Text('Ciudad: ${_userProfile!['city']}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _cerrarSesion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        disabledBackgroundColor: Colors.white,
                      ),
                      child: const Text('Cerrar Sesión'),
                    ),
                  ],
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
