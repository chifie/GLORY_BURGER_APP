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
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientation and system UI overlay for a polished experience.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // White icons for dark red header
    statusBarBrightness: Brightness.dark,  // For iOS dark status bar
  ));

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
  String _selectedPaymentMethod = 'Credit/Debit Card';

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
      appBar: AppBar(
        title: Hero(
          tag: 'app-logo',
          child: Image.asset(
            'lib/assets/images/logo.png',
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryRed, AppColors.darkRed],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text('Glory Burger Enthusiast', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text('customer@gloryburger.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Image(image: AssetImage('lib/assets/images/logo.png')),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment_outlined),
              title: const Text('Payment Methods'),
              subtitle: Text(_selectedPaymentMethod, style: const TextStyle(fontSize: 12, color: AppColors.mediumGrey)),
              onTap: () {
                Navigator.pop(context);
                // Navigate to payment method or open a bottom sheet
                _showPaymentMethods(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Order History'),
              onTap: () {
                Navigator.pop(context);
                _onTabSelected(2);
              },
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
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

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkCharcoal),
            ),
            const SizedBox(height: 4),
            const Text(
              'Choose your preferred way to pay',
              style: TextStyle(fontSize: 12, color: AppColors.mediumGrey),
            ),
            const SizedBox(height: 16),

            // Credit/Debit Card
            _buildPaymentTile(
              icon: Icons.credit_card,
              color: AppColors.primaryRed,
              title: 'Credit/Debit Card',
              subtitle: 'Visa, Mastercard & more',
              isSelected: _selectedPaymentMethod == 'Credit/Debit Card',
              onTap: () => _updatePaymentMethod('Credit/Debit Card'),
            ),

            // M-Pesa
            _buildPaymentTile(
              icon: Icons.phone_android,
              color: const Color(0xFF4CAF50),
              title: 'M-Pesa',
              subtitle: 'Pay via M-Pesa mobile money',
              isSelected: _selectedPaymentMethod == 'M-Pesa',
              onTap: () => _updatePaymentMethod('M-Pesa'),
            ),

            // HaloPesa
            _buildPaymentTile(
              icon: Icons.account_balance_wallet,
              color: const Color(0xFF1565C0),
              title: 'HaloPesa',
              subtitle: 'Pay via HaloPesa mobile wallet',
              isSelected: _selectedPaymentMethod == 'HaloPesa',
              onTap: () => _updatePaymentMethod('HaloPesa'),
            ),

            // Mix by Yas
            _buildPaymentTile(
              icon: Icons.swap_horiz,
              color: const Color(0xFFE91E63),
              title: 'Mix by Yas',
              subtitle: 'Pay via Mix by Yas',
              isSelected: _selectedPaymentMethod == 'Mix by Yas',
              onTap: () => _updatePaymentMethod('Mix by Yas'),
            ),

            // Airtel Money
            _buildPaymentTile(
              icon: Icons.sim_card,
              color: const Color(0xFFFF1744),
              title: 'Airtel Money',
              subtitle: 'Pay via Airtel Money',
              isSelected: _selectedPaymentMethod == 'Airtel Money',
              onTap: () => _updatePaymentMethod('Airtel Money'),
            ),

            // Cash on Delivery
            _buildPaymentTile(
              icon: Icons.money,
              color: const Color(0xFFFF9800),
              title: 'Cash on Delivery',
              subtitle: 'Pay when you receive your order',
              isSelected: _selectedPaymentMethod == 'Cash on Delivery',
              onTap: () => _updatePaymentMethod('Cash on Delivery'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected ? color.withValues(alpha: 0.08) : AppColors.offWhite,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkCharcoal,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.mediumGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.successGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updatePaymentMethod(String method) {
    setState(() => _selectedPaymentMethod = method);
    Navigator.pop(context);
  }
}
