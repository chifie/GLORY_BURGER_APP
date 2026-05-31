import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../features/splash/splash_screen.dart';
import '../features/home/home_screen.dart';
import '../features/food_details/food_details_screen.dart';
import '../features/cart/cart_screen.dart';
import '../features/checkout/checkout_screen.dart';
import '../features/orders/orders_screen.dart';
import '../features/profile/profile_screen.dart';

/// Route generator that maps route names to screen widgets.
/// Used by MaterialApp.onGenerateRoute for centralized navigation.
class RouteGenerator {
  RouteGenerator._();

  /// Generates a Route based on the provided RouteSettings.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Optional: extract arguments passed during navigation
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(const SplashScreen(), settings);

      case AppRoutes.home:
        return _buildRoute(const HomeScreen(), settings);

      case AppRoutes.foodDetails:
        // Expect a foodId argument for the details screen
        final foodId = args as String?;
        if (foodId == null) {
          return _buildErrorRoute('Food ID is required');
        }
        return _buildRoute(FoodDetailsScreen(foodId: foodId), settings);

      case AppRoutes.cart:
        return _buildRoute(const CartScreen(), settings);

      case AppRoutes.checkout:
        return _buildRoute(const CheckoutScreen(), settings);

      case AppRoutes.orders:
        return _buildRoute(const OrdersScreen(), settings);

      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen(), settings);

      default:
        return _buildErrorRoute('Route "${settings.name}" not found');
    }
  }

  /// Creates a MaterialPageRoute with a smooth slide transition.
  static MaterialPageRoute _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }

  /// Creates an error route for unknown or misconfigured paths.
  static MaterialPageRoute _buildErrorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
