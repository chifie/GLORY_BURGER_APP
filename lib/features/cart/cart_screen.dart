import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/quantity_selector.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../routes/app_routes.dart';

/// Cart screen showing all selected food items with quantity controls.
/// Displays subtotal, delivery fee, total amount, and a checkout button.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: AppColors.white,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          // Empty cart state
          if (cartProvider.isEmpty) {
            return _buildEmptyCart(context);
          }

          return Column(
            children: [
              // ── Cart Items List ──────────────────────────────
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartProvider.cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return _buildCartItemCard(context, cartItem, cartProvider);
                  },
                ),
              ),

              // ── Order Summary ────────────────────────────────
              _buildOrderSummary(context, cartProvider),
            ],
          );
        },
      ),
    );
  }

  /// Builds the empty cart placeholder
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: AppColors.lightGrey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.darkCharcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add some delicious items to get started!',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGrey,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            child: CustomButton(
              label: 'Browse Menu',
              icon: Icons.restaurant_menu,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single cart item card with image, info, and controls
  Widget _buildCartItemCard(
    BuildContext context,
    CartItem cartItem,
    CartProvider cartProvider,
  ) {
    return Dismissible(
      key: Key(cartItem.food.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        cartProvider.removeFromCart(cartItem.food.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${cartItem.food.name} removed from cart'),
            duration: AppConstants.snackbarDuration,
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.errorRed,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: AppColors.white,
          size: 28,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkCharcoal.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Food Image Placeholder ─────────────────────────
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  _getCategoryIcon(cartItem.food.category),
                  size: 30,
                  color: AppColors.primaryRed.withValues(alpha: 0.4),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ── Food Info ──────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Helpers.formatPrice(cartItem.food.price),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryRed,
                    ),
                  ),
                ],
              ),
            ),

            // ── Quantity Controls ──────────────────────────────
            QuantitySelector(
              quantity: cartItem.quantity,
              onIncrease: () =>
                  cartProvider.increaseQuantity(cartItem.food.id),
              onDecrease: () =>
                  cartProvider.decreaseQuantity(cartItem.food.id),
              compact: true,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the order summary section at the bottom of the cart
  Widget _buildOrderSummary(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkCharcoal.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Subtotal
            _buildSummaryRow(
              'Subtotal',
              Helpers.formatPrice(cartProvider.subtotal),
            ),
            const SizedBox(height: 8),

            // Delivery fee
            _buildSummaryRow(
              'Delivery Fee',
              cartProvider.deliveryFee == 0
                  ? 'FREE'
                  : Helpers.formatPrice(cartProvider.deliveryFee),
              valueColor: cartProvider.deliveryFee == 0
                  ? AppColors.successGreen
                  : null,
            ),
            const SizedBox(height: 12),

            // Divider
            const Divider(color: AppColors.lightGrey, thickness: 1),
            const SizedBox(height: 12),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkCharcoal,
                  ),
                ),
                Text(
                  Helpers.formatPrice(cartProvider.total),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Checkout button
            CustomButton(
              label: 'Proceed to Checkout',
              icon: Icons.payment,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.checkout);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a single row in the order summary
  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.mediumGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.darkCharcoal,
          ),
        ),
      ],
    );
  }

  /// Returns an icon for each food category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Burgers':
        return Icons.lunch_dining;
      case 'Pizza':
        return Icons.local_pizza;
      case 'Drinks':
        return Icons.local_drink;
      case 'Fries':
        return Icons.fastfood;
      default:
        return Icons.restaurant;
    }
  }
}
