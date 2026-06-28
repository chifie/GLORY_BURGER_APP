import '../api/api_client.dart';

class OrderService {
  static Future createOrder(
    String token, {
    required String customerName,
    required String phone,
    required String address,
    required List<Map<String, dynamic>> items,
    String paymentMethod = 'M-Pesa',
    String? paymentPhone,
  }) {
    return ApiClient.post("/orders", {
      "customerName": customerName,
      "phone": phone,
      "address": address,
      "items": items,
      "paymentMethod": paymentMethod,
      if (paymentPhone != null) "paymentPhone": paymentPhone,
    }, token: token);
  }

  static Future getOrders(String token) {
    return ApiClient.get("/orders", token: token);
  }

  static Future getOrderById(String token, String orderId) {
    return ApiClient.get("/orders/$orderId", token: token);
  }
}
