import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/order_model.dart';
import '../core/constants/app_constants.dart';

/// Provider that manages order placement and order history.
/// Simulates order status progression for demo purposes.
class OrderProvider extends ChangeNotifier {
  // ── State ─────────────────────────────────────────────────────
  final List<OrderModel> _orders = [];
  int _orderCounter = 0;

  // ── Getters ───────────────────────────────────────────────────
  List<OrderModel> get orders => List.unmodifiable(_orders);
  bool get hasOrders => _orders.isNotEmpty;

  /// Places a new order from the current cart items.
  /// Returns the generated order ID.
  String placeOrder({
    required List<CartItem> cartItems,
    required double subtotal,
    required double deliveryFee,
    required double total,
    required String customerName,
    required String phone,
    required String address,
    String paymentMethod = 'M-Pesa',
  }) {
    _orderCounter++;
    final orderId = 'GB-${DateTime.now().year}-${_orderCounter.toString().padLeft(4, '0')}';

    // Deep copy cart items to prevent mutation after order is placed
    final orderItems = cartItems
        .map((item) => CartItem(food: item.food, quantity: item.quantity))
        .toList();

    final order = OrderModel(
      id: orderId,
      items: orderItems,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      customerName: customerName,
      phone: phone,
      address: address,
      status: AppConstants.statusPending,
      paymentMethod: paymentMethod,
      orderDate: DateTime.now(),
    );

    _orders.insert(0, order); // Newest first
    notifyListeners();

    // Simulate order status progression
    _simulateOrderProgress(orderId);

    return orderId;
  }

  /// Simulates order status changes over time for demo purposes.
  /// In a real app, this would be driven by backend WebSocket events.
  void _simulateOrderProgress(String orderId) {
    // Move to "Preparing" after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      _updateOrderStatus(orderId, AppConstants.statusPreparing);
    });

    // Move to "On Delivery" after 15 seconds
    Future.delayed(const Duration(seconds: 15), () {
      _updateOrderStatus(orderId, AppConstants.statusOnDelivery);
    });

    // Move to "Delivered" after 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      _updateOrderStatus(orderId, AppConstants.statusDelivered);
    });
  }

  /// Updates the status of a specific order by its ID.
  void _updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index >= 0) {
      _orders[index] = _orders[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  /// Returns orders filtered by a specific status.
  List<OrderModel> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  /// Returns the most recent order (if any).
  OrderModel? get latestOrder => _orders.isNotEmpty ? _orders.first : null;
}
