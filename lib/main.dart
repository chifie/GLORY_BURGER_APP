import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_bottom_nav_bar.dart';
import 'features/home/home_screen.dart';
import 'features/cart/cart_screen.dart';
import 'features/orders/orders_screen.dart';
import 'features/profile/profile_screen.dart';
import 'providers/food_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/profile_provider.dart';
import 'routes/app_routes.dart';
import 'routes/route_generator.dart';

/// Main entry point for the Glory Burger food ordering app.
void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientation and system UI overlay for a polished experience.
  // Locking to portrait is standard for food delivery apps on mobile.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light, // For iOS
    ));
  });

  runApp(
    // MultiProvider wraps the entire app with all necessary state providers.
    // This allows any widget in the tree to access and react to state changes.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const GloryBurgerApp(),
    ),
  );
}

/// Root widget for the Glory Burger application.
/// Sets up Material Design 3 theming, routing, and the provider tree.
class GloryBurgerApp extends StatelessWidget {
  const GloryBurgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glory Burger',
      debugShowCheckedModeBanner: false,

      // Theme configuration (Material Design 3 with KFC-inspired colors)
      theme: AppTheme.lightTheme,

      // Route configuration
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

/// AppShell — the main scaffold with bottom navigation.
/// Manages tab switching between Home, Cart, Orders, and Profile.
/// This widget is displayed after the splash screen completes.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  // The main screens for each tab
  final List<Widget> _screens = const [
    HomeScreen(),
    CartScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  /// Handles tab selection from the bottom navigation bar
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return AppBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTabSelected,
            cartItemCount: cartProvider.itemCount,
          );
        },
      ),
    );
  }
}
