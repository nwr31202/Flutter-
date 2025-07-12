import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://movie-api.nwr312027.repl.co';

  static Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', data['user']['email']);
      prefs.setString('plan', data['user']['plan']);
      return true;
    } else {
      return false;
    }
  }

  static Future<List<dynamic>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/api/movies'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<void> upgradePlan(String email, String plan) async {
    await http.post(
      Uri.parse('$baseUrl/api/upgrade'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'plan': plan}),
    );
  }

  static Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('email') ?? '',
      'plan': prefs.getString('plan') ?? 'free',
    };
  }
}
