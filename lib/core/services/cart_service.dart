import '../api/api_client.dart';

class CartService {
  static Future getCart(String token) {
    return ApiClient.get("/cart", token: token);
  }

  static Future addToCart(String token, String foodItemId, int quantity) {
    return ApiClient.post("/cart", {
      "foodItemId": foodItemId,
      "quantity": quantity
    }, token: token);
  }
}
