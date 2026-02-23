import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://TUO-BACKEND-URL/api"; // cambia con il tuo backend

  static Future<Map<String, dynamic>> fetchPlayer(String username) async {
    final response =
        await http.get(Uri.parse("$baseUrl/player/$username"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Player not found");
    }
  }
}
