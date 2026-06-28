import '../api/api_client.dart';

class CartService {
  static Future getCart(String token) {
    return ApiClient.get("/cart", token: token);
  }

  static Future addToCart(String token, String foodItemId, int quantity) {
    return ApiClient.post("/cart", {
      "foodItemId": foodItemId,
      "quantity": quantity,
    }, token: token);
  }

  static Future updateItem(String token, String cartItemId, int quantity) {
    return ApiClient.put("/cart/$cartItemId", {
      "quantity": quantity,
    }, token: token);
  }

  static Future removeItem(String token, String cartItemId) {
    return ApiClient.delete("/cart/$cartItemId", token: token);
  }

  static Future clearCart(String token) {
    return ApiClient.delete("/cart", token: token);
  }

  static Future getItemCount(String token) {
    return ApiClient.get("/cart/count", token: token);
  }
}
