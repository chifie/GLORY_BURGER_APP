/// Named route constants used throughout the app.
/// Centralizes all route names to avoid hard-coding strings.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String foodDetails = '/food-details';
  static const String cart = '/cart';
  static const String appShell = '/app-shell';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String profile = '/profile';
  static const String notifications = '/notifications';

  /// The initial route when the app launches
  static const String initialRoute = splash;
}
