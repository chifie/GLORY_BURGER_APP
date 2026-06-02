/// Application-wide constant values used across features.
class AppConstants {
  AppConstants._();

  // ── App Info ──────────────────────────────────────────────────
  static const String appName = 'Glory Burger';
  static const String appTagline = 'Taste the Glory!';

  // ── Navigation ────────────────────────────────────────────────
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackbarDuration = Duration(seconds: 2);

  // ── Pagination & Limits ───────────────────────────────────────
  static const int defaultPageSize = 20;
  static const int maxCartQuantity = 99;
  static const int minCartQuantity = 1;

  // ── Delivery ──────────────────────────────────────────────────
  static const double deliveryFee = 2500.0; // in TZS
  static const double freeDeliveryThreshold = 25000.0; // free above this
  static const String currencySymbol = 'TZS';
  static const String currencyCode = 'TZS';

  // ── Order Statuses ────────────────────────────────────────────
  static const String statusPending = 'Pending';
  static const String statusPreparing = 'Preparing';
  static const String statusOnDelivery = 'On Delivery';
  static const String statusDelivered = 'Delivered';

  // ── Validation ────────────────────────────────────────────────
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 13;
  static const int minNameLength = 2;
  static const int minAddressLength = 5;

  // ── Food Categories ───────────────────────────────────────────
  static const List<String> categories = [
    'Burgers',
  ];

  // ── Asset Paths ───────────────────────────────────────────────
  static const String logoPath = 'assets/images/logo.png';
  static const String bannerPath = 'assets/images/banner.png';
  static const String placeholderPath = 'assets/images/placeholder.png';
}
