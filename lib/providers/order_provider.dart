import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../core/services/order_service.dart';
import '../core/api/api_client.dart';
import '../core/constants/app_constants.dart';

/// Represents a placed order from the backend.
class OrderModel {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String customerName;
  final String phone;
  final String address;
  final String status;
  final String paymentMethod;
  final String? paymentPhone;
  final DateTime orderDate;

  OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.customerName,
    required this.phone,
    required this.address,
    this.status = 'Pending',
    this.paymentMethod = 'M-Pesa',
    this.paymentPhone,
    required this.orderDate,
  });

  OrderModel copyWith({String? status}) {
    return OrderModel(
      id: id,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      customerName: customerName,
      phone: phone,
      address: address,
      status: status ?? this.status,
      paymentMethod: paymentMethod,
      paymentPhone: paymentPhone,
      orderDate: orderDate,
    );
  }
}

/// Provider that manages order placement and order history.
/// Communicates with the backend API for all operations.
class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => List.unmodifiable(_orders);
  bool get hasOrders => _orders.isNotEmpty;
  bool get isLoading => _isLoading;
  String? get error => _error;
  OrderModel? get latestOrder => _orders.isNotEmpty ? _orders.first : null;

  /// Places a new order by calling the backend.
  /// Returns the order ID on success, null on failure.
  Future<String?> placeOrder({
    required String token,
    required List<CartItem> cartItems,
    required String customerName,
    required String phone,
    required String address,
    String paymentMethod = 'M-Pesa',
    String? paymentPhone,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final items = cartItems.map((item) => {
        'foodItemId': item.food.id,
        'quantity': item.quantity,
      }).toList();

      final res = await OrderService.createOrder(
        token,
        customerName: customerName,
        phone: phone,
        address: address,
        items: items,
        paymentMethod: paymentMethod,
        paymentPhone: paymentPhone,
      );

      if (res['success'] == true) {
        final data = res['data'] as Map<String, dynamic>;
        final orderId = data['id']?.toString() ?? data['orderId']?.toString() ?? '';

        // Build local order model for immediate UI feedback
        final order = OrderModel(
          id: orderId,
          items: List.from(cartItems),
          subtotal: cartItems.fold(0.0, (sum, i) => sum + i.total),
          deliveryFee: AppConstants.deliveryFee,
          total: cartItems.fold(0.0, (sum, i) => sum + i.total) + AppConstants.deliveryFee,
          customerName: customerName,
          phone: phone,
          address: address,
          status: AppConstants.statusPending,
          paymentMethod: paymentMethod,
          paymentPhone: paymentPhone,
          orderDate: DateTime.now(),
        );

        _orders.insert(0, order);
        _isLoading = false;
        notifyListeners();
        return orderId;
      }

      _error = res['message']?.toString() ?? 'Order failed';
      _isLoading = false;
      notifyListeners();
      return null;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Could not place order. Check your connection.';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Fetches order history from the backend.
  Future<void> fetchOrders(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await OrderService.getOrders(token);
      // Orders are already in _orders from placeOrder; backend list refreshes them
      _isLoading = false;
      notifyListeners();
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Could not load orders. Check your connection.';
      _isLoading = false;
      notifyListeners();
    }
  }

  List<OrderModel> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
