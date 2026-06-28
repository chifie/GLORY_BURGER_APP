import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../core/services/food_service.dart';
import '../core/api/api_client.dart';

/// Provider that manages the food catalog, category filtering,
/// and search functionality. Fetches data from the backend API.
class FoodProvider extends ChangeNotifier {
  List<FoodItem> _allFoods = [];
  List<FoodItem> _filteredFoods = [];
  List<FoodItem> _popularFoods = [];
  String _selectedCategory = 'Burgers';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;

  List<FoodItem> get allFoods => _allFoods;
  List<FoodItem> get filteredFoods => _filteredFoods;
  List<FoodItem> get popularFoods => _popularFoods;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;

  FoodProvider() {
    loadFoods();
  }

  /// Fetches food items from the backend API.
  Future<void> loadFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final foodsRes = await FoodService.getFoods();
      final popularRes = await FoodService.getPopularFoods();

      if (foodsRes['success'] == true) {
        _allFoods = (foodsRes['data'] as List)
            .map((j) => FoodItem.fromJson(j as Map<String, dynamic>))
            .toList();
      }

      if (popularRes['success'] == true) {
        _popularFoods = (popularRes['data'] as List)
            .map((j) => FoodItem.fromJson(j as Map<String, dynamic>))
            .toList();
      }

      _filterFoods();
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'Could not load menu. Check your connection.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sets the selected category and re-filters the food list.
  void setCategory(String category) {
    _selectedCategory = category;
    _filterFoods();
    notifyListeners();
  }

  /// Updates the search query and re-filters the food list.
  void setSearchQuery(String query) {
    _searchQuery = query;
    _filterFoods();
    notifyListeners();
  }

  /// Clears the search query and resets filtering.
  void clearSearch() {
    _searchQuery = '';
    _filterFoods();
    notifyListeners();
  }

  /// Returns food items grouped by sub-category.
  Map<String, List<FoodItem>> getFoodsBySubCategory(List<FoodItem> foods) {
    final Map<String, List<FoodItem>> grouped = {};
    for (final food in foods) {
      final sub = food.subCategory.isNotEmpty ? food.subCategory : 'All';
      grouped.putIfAbsent(sub, () => []);
      grouped[sub]!.add(food);
    }
    return grouped;
  }

  /// Returns a specific food item by its ID.
  FoodItem? getFoodById(String id) {
    try {
      return _allFoods.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }

  void _filterFoods() {
    List<FoodItem> result = _allFoods;

    if (_selectedCategory.isNotEmpty) {
      result = result
          .where((food) => food.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      result = result
          .where((food) =>
              food.name.toLowerCase().contains(lowerQuery) ||
              food.description.toLowerCase().contains(lowerQuery))
          .toList();
    }

    _filteredFoods = result;
  }
}
