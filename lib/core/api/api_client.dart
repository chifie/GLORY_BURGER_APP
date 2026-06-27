import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "http://192.168.27.177:3000/api/v1";

  static Map<String, String> headers(String? token) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future get(String endpoint, {String? token}) async {
    final res = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers(token),
    );
    return jsonDecode(res.body);
  }

  static Future post(String endpoint, dynamic data, {String? token}) async {
    final res = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers(token),
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }
}
