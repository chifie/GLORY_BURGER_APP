import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  // For Android emulator use: http://10.0.2.2:3000/api/v1
  // For iOS simulator use:    http://localhost:3000/api/v1
  // For physical device:      http://<YOUR_COMPUTER_IP>:3000/api/v1
  static const String baseUrl = "http://10.0.2.2:3000/api/v1";

  static Map<String, String> headers(String? token) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  /// Decodes a response and throws a descriptive error on non-2xx status.
  static dynamic _decode(http.Response res) {
    final body = jsonDecode(res.body);
    if (res.statusCode >= 200 && res.statusCode < 300) return body;
    final message = body['message'] ?? 'Request failed (${res.statusCode})';
    throw ApiException(message is List ? message.join(', ') : message.toString(), res.statusCode);
  }

  static Future get(String endpoint, {String? token}) async {
    final res = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers(token),
    );
    return _decode(res);
  }

  static Future post(String endpoint, dynamic data, {String? token}) async {
    final res = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers(token),
      body: jsonEncode(data),
    );
    return _decode(res);
  }

  static Future put(String endpoint, dynamic data, {String? token}) async {
    final res = await http.put(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers(token),
      body: jsonEncode(data),
    );
    return _decode(res);
  }

  static Future delete(String endpoint, {String? token}) async {
    final res = await http.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers(token),
    );
    return _decode(res);
  }
}

/// Thrown when the backend returns a non-2xx HTTP response.
class ApiException implements Exception {
  final String message;
  final int statusCode;
  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
