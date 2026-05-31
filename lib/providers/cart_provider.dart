import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../core/constants/app_constants.dart';

/// Provider that manages the shopping cart state.
/// Handles adding, removing, and updating item quantities.
class CartProvider extends ChangeNotifier {
  // ── State ─────────────────────────────────────────────────────
  final List<CartItem> _cartItems = [];

  // ── Getters ───────────────────────────────────────────────────
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => _cartItems.isEmpty;

  /// Subtotal of all items (before delivery fee)
  double get subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.total);

  /// Delivery fee — free if subtotal exceeds threshold
  double get deliveryFee =>
      subtotal >= AppConstants.freeDeliveryThreshold
          ? 0.0
          : AppConstants.deliveryFee;

  /// Total amount payable (subtotal + delivery fee)
  double get total => subtotal + deliveryFee;

  /// Adds a food item to the cart. If it already exists, increments quantity.
  void addToCart(FoodItem food, {int quantity = 1}) {
    final existingIndex =
        _cartItems.indexWhere((item) => item.food.id == food.id);

    if (existingIndex >= 0) {
      // Item already in cart — increase quantity
      _cartItems[existingIndex].quantity += quantity;
      if (_cartItems[existingIndex].quantity > AppConstants.maxCartQuantity) {
        _cartItems[existingIndex].quantity = AppConstants.maxCartQuantity;
      }
    } else {
      // New item — add to cart
      _cartItems.add(CartItem(food: food, quantity: quantity));
    }
    notifyListeners();
  }

  /// Removes a food item from the cart entirely.
  void removeFromCart(String foodId) {
    _cartItems.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  /// Increases the quantity of a specific cart item by 1.
  void increaseQuantity(String foodId) {
    final index =
        _cartItems.indexWhere((item) => item.food.id == foodId);
    if (index >= 0) {
      if (_cartItems[index].quantity < AppConstants.maxCartQuantity) {
        _cartItems[index].quantity++;
        notifyListeners();
      }
    }
  }

  /// Decreases the quantity of a specific cart item by 1.
  /// Removes the item if quantity drops below 1.
  void decreaseQuantity(String foodId) {
    final index =
        _cartItems.indexWhere((item) => item.food.id == foodId);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Clears all items from the cart.
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// Returns the quantity of a specific food item in the cart.
  int getQuantity(String foodId) {
    final index =
        _cartItems.indexWhere((item) => item.food.id == foodId);
    return index >= 0 ? _cartItems[index].quantity : 0;
  }
}
