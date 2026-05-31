import '../constants/app_constants.dart';

/// Utility helpers used across the app for formatting, validation, etc.
class Helpers {
  Helpers._();

  /// Formats a numeric amount into a readable currency string.
  /// Example: 15000 → "15,000 TZS"
  static String formatPrice(double amount) {
    final formatted = amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    return '$formatted ${AppConstants.currencySymbol}';
  }

  /// Formats price without the currency symbol.
  /// Example: 15000 → "15,000"
  static String formatPriceShort(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  /// Returns the order status color based on the current status string.
  static int getOrderStatusIndex(String status) {
    switch (status) {
      case AppConstants.statusPending:
        return 0;
      case AppConstants.statusPreparing:
        return 1;
      case AppConstants.statusOnDelivery:
        return 2;
      case AppConstants.statusDelivered:
        return 3;
      default:
        return 0;
    }
  }

  /// Truncates text that exceeds [maxLength] and appends "..."
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Validates a Tanzanian phone number (basic check).
  /// Accepts formats: 07XXXXXXXX, +2557XXXXXXXX, 2557XXXXXXXX
  static bool isValidPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\s+'), '');
    if (cleaned.length < AppConstants.minPhoneLength ||
        cleaned.length > AppConstants.maxPhoneLength) {
      return false;
    }
    return RegExp(r'^(\+?255|0)\d{8,9}$').hasMatch(cleaned);
  }

  /// Validates that a name is at least [minLength] characters.
  static bool isValidName(String name) {
    return name.trim().length >= AppConstants.minNameLength;
  }

  /// Validates that an address is at least [minLength] characters.
  static bool isValidAddress(String address) {
    return address.trim().length >= AppConstants.minAddressLength;
  }

  /// Returns a human-readable order status tracker label.
  static String getStatusLabel(int index) {
    switch (index) {
      case 0:
        return AppConstants.statusPending;
      case 1:
        return AppConstants.statusPreparing;
      case 2:
        return AppConstants.statusOnDelivery;
      case 3:
        return AppConstants.statusDelivered;
      default:
        return AppConstants.statusPending;
    }
  }
}
