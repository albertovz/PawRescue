import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paw/User/Ad/Models/Ad.dart';
import 'package:paw/Pet/Ad/Models/Pet.dart';

class ApiService {
  static const String baseUrl = 'http://10.11.3.153:3000/api';

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final url = Uri.parse('$baseUrl/user/login');
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final userId = responseData['data']['user'];
        final token = responseData['data']['token'];
        return {'userId': userId, 'token': token};
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  static Future<void> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user//create'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // The request was successful, you can take actions in response to this
        print('Registro exitoso');
      } else {
        // The request failed, handle the error according to your needs
        print('Error en el registro: ${response.statusCode}');
      }
    } catch (e) {
      // An error occurred in the connection or request
      print('Error en la conexión: $e');
    }
  }

  static Future<Map<String, dynamic>> getUserProfile(
      String token, String userId) async {
    final url = Uri.parse('$baseUrl/user/profile/$userId');
    try {
      final response = await http.get(
        url,
        headers: {'auth-token': token},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      // Handle the error here or re-throw to be handled in the caller.
      throw e;
    }
  }

  static Future<bool> updateUserProfile(
      String token, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/update/profile'),
        headers: {
          'Content-Type': 'application/json',
          'auth-token': token,
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        return true;
      } else {
        // La solicitud falló, maneja el error según tus necesidades
        print('Error en el registro: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Ocurrió un error en la conexión o la solicitud
      print('Error en la conexión: $e');
      return false;
    }
  }

  static Future<String> createAd(
    String token,
    String title,
    String description,
    String ubication,
    String datePublication,
    bool statusAd,
    String catUserId,
  ) async {
    // Data for the ad in JSON format
    final adData = {
      'title': title,
      'descriptionAd': description,
      'ubication': ubication,
      'datePublication': datePublication,
      'statusAd': statusAd,
      'catUserId': catUserId,
    };

    // URL of the API in the backend
    const apiUrl = '$baseUrl/ads/create';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'auth-token': token,
        },
        body: json.encode(adData),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Ad created successfully');
        final responseData = json.decode(response.body);
        print(responseData);
        final String adId = responseData['id'];

        return adId;
        // The request was successful
      } else {
        // There was an error in the request
        print('Error creating the ad: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in the request: $e');
    }
    return 'bad';
  }

  static Future<List<Mascota>> fetchDataPet(String token) async {
    final url = Uri.parse('$baseUrl/pet/list');

    try {
      final response = await http.get(
        url,
        headers: {
          'auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return List<Mascota>.from(
            jsonData.map((data) => Mascota.fromJson(data)));
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<List<Ad>> fetchDataAd(String token) async {
    final url = Uri.parse('$baseUrl/ads/list');

    try {
      final response = await http.get(
        url,
        headers: {
          'auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return List<Ad>.from(jsonData.map((data) => Ad.fromJson(data)));
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
