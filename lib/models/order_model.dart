import 'cart_item.dart';

/// Represents a placed order with delivery details and status tracking.
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
  final String? paymentPhone; // Phone number for mobile money payment
  final DateTime orderDate;

  const OrderModel({
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
    this.paymentPhone, // New optional field for payment number
    required this.orderDate,
  });

  /// Creates a copy with optional field overrides
  OrderModel copyWith({
    String? id,
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
    String? customerName,
    String? phone,
    String? address,
    String? status,
    String? paymentMethod,
    String? paymentPhone, // New field
    DateTime? orderDate,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentPhone: paymentPhone ?? this.paymentPhone,
      orderDate: orderDate ?? this.orderDate,
    );
  }
}