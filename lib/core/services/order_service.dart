import '../api/api_client.dart';

class OrderService {
  static Future createOrder(String token) {
    return ApiClient.post("/orders", {}, token: token);
  }

  static Future getOrders(String token) {
    return ApiClient.get("/orders", token: token);
  }
}
