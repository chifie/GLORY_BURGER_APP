import 'package:flutter/foundation.dart';

/// Represents a single notification item.
class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.type = NotificationType.info,
  });

  /// Creates a copy with optional field overrides.
  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }
}

/// Types of notifications for icon/color differentiation.
enum NotificationType {
  order,
  cart,
  promo,
  info,
}

/// Provider that manages in-app notifications.
/// Notifications are triggered by cart additions, order updates, etc.
class NotificationProvider extends ChangeNotifier {
  final List<AppNotification> _notifications = [];

  // ── Getters ───────────────────────────────────────────────────
  List<AppNotification> get notifications =>
      List.unmodifiable(_notifications);

  List<AppNotification> get unreadNotifications =>
      _notifications.where((n) => !n.isRead).toList();

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // ── Add Notification ──────────────────────────────────────────
  /// Adds a new notification to the list (newest first).
  void addNotification({
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
  }) {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      timestamp: DateTime.now(),
      type: type,
    );
    _notifications.insert(0, notification);
    notifyListeners();
  }

  // ── Mark as Read ──────────────────────────────────────────────
  /// Marks a single notification as read.
  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] =
          _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  /// Marks all notifications as read.
  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    notifyListeners();
  }

  // ── Clear ─────────────────────────────────────────────────────
  /// Clears all notifications.
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  // ── Convenience Adders ────────────────────────────────────────
  void notifyItemAddedToCart(String itemName) {
    addNotification(
      title: 'Added to Cart',
      message: '$itemName has been added to your cart.',
      type: NotificationType.cart,
    );
  }

  void notifyOrderPlaced(String orderId) {
    addNotification(
      title: 'Order Placed',
      message: 'Order #$orderId has been placed successfully!',
      type: NotificationType.order,
    );
  }

  void notifyOrderStatusChanged(String orderId, String status) {
    addNotification(
      title: 'Order Update',
      message: 'Order #$orderId is now $status.',
      type: NotificationType.order,
    );
  }

  void notifyPromo(String promoMessage) {
    addNotification(
      title: 'Special Offer',
      message: promoMessage,
      type: NotificationType.promo,
    );
  }
}