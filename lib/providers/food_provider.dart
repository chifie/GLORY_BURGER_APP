import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/mock_data.dart';

/// Provider that manages the food catalog, category filtering,
/// and search functionality. Uses mock data as the data source.
class FoodProvider extends ChangeNotifier {
  // ── State ─────────────────────────────────────────────────────
  List<FoodItem> _allFoods = [];
  List<FoodItem> _filteredFoods = [];
  List<FoodItem> _popularFoods = [];
  String _selectedCategory = 'Burgers';
  String _searchQuery = '';
  bool _isLoading = false;

  // ── Getters ───────────────────────────────────────────────────
  List<FoodItem> get allFoods => _allFoods;
  List<FoodItem> get filteredFoods => _filteredFoods;
  List<FoodItem> get popularFoods => _popularFoods;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  /// Initializes the provider by loading mock data.
  FoodProvider() {
    loadFoods();
  }

  /// Loads food items from the mock data source.
  void loadFoods() {
    _isLoading = true;
    notifyListeners();

    // Simulate a small network delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _allFoods = MockData.foodItems;
      _popularFoods = MockData.popularItems;
      _filterFoods();
      _isLoading = false;
      notifyListeners();
    });
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

  /// Returns a specific food item by its ID.
  FoodItem? getFoodById(String id) {
    try {
      return _allFoods.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Internal method to filter foods based on category and search query.
  void _filterFoods() {
    List<FoodItem> result = _allFoods;

    // Filter by category first
    if (_selectedCategory.isNotEmpty) {
      result = result
          .where((food) => food.category == _selectedCategory)
          .toList();
    }

    // Then apply search filter if query is not empty
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
