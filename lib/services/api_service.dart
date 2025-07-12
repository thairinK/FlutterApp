import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _base = 'http://10.0.2.2:3000/api';

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final res = await http.post(Uri.parse('$_base/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}));
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(Uri.parse('$_base/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}));
    return jsonDecode(res.body);
  }
}
