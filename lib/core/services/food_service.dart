import '../api/api_client.dart';

class FoodService {
  static Future getFoods({String? category, String? search}) {
    String endpoint = "/foods";
    final params = <String, String>{};
    if (category != null && category.isNotEmpty) params['category'] = category;
    if (search != null && search.isNotEmpty) params['search'] = search;
    if (params.isNotEmpty) {
      endpoint += '?' + params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&');
    }
    return ApiClient.get(endpoint);
  }

  static Future getPopularFoods() {
    return ApiClient.get("/foods/popular");
  }

  static Future searchFoods(String query) {
    return ApiClient.get("/foods/search?q=${Uri.encodeComponent(query)}");
  }

  static Future getFoodById(String id) {
    return ApiClient.get("/foods/$id");
  }
}
