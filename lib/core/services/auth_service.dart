import '../api/api_client.dart';

class AuthService {
  static Future register(String name, String email, String password, String phone) {
    return ApiClient.post("/auth/register", {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    });
  }

  static Future login(String email, String password) {
    return ApiClient.post("/auth/login", {
      "email": email,
      "password": password,
    });
  }
}
