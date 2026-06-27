import '../api/api_client.dart';

class FoodService {
  static Future getFoods() {
    return ApiClient.get("/foods");
  }

  static Future getFoodById(String id) {
    return ApiClient.get("/foods/$id");
  }
}
