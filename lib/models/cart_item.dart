import 'food_item.dart';

/// Represents a food item added to the shopping cart with a quantity.
class CartItem {
  final FoodItem food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
  });

  /// Returns the line total for this cart item (price × quantity)
  double get total => food.price * quantity;

  /// Creates a copy with an updated quantity
  CartItem copyWith({int? quantity}) {
    return CartItem(
      food: food,
      quantity: quantity ?? this.quantity,
    );
  }
}
