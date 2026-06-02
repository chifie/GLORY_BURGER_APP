import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/quantity_selector.dart';
import '../../models/food_item.dart';
import '../../providers/food_provider.dart';
import '../../providers/cart_provider.dart';
import '../../routes/app_routes.dart';

/// Food Details screen showing full info about a selected food item.
/// Includes image, name, description, price, quantity selector, and
/// an "Add to Cart" button.
class FoodDetailsScreen extends StatefulWidget {
  final String foodId;

  const FoodDetailsScreen({
    super.key,
    required this.foodId,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final foodProvider = context.watch<FoodProvider>();
    final food = foodProvider.getFoodById(widget.foodId);

    // Show error if food item not found
    if (food == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Item Not Found')),
        body: const Center(
          child: Text(
            'This food item could not be found.',
            style: TextStyle(fontSize: 16, color: AppColors.mediumGrey),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: CustomScrollView(
        slivers: [
          // ── Sliver App Bar with Hero Image ────────────────────
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryRed,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.95),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkCharcoal.withValues(alpha: 0.15),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.darkCharcoal,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'food_${food.id}',
                child: Container(
                  color: AppColors.offWhite,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (food.imageUrl.isNotEmpty)
                        Image.asset(
                          food.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),
                                Icon(
                                  _getCategoryIcon(food.category),
                                  size: 100,
                                  color: AppColors.primaryRed
                                      .withValues(alpha: 0.3),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  food.category,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.mediumGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              Icon(
                                _getCategoryIcon(food.category),
                                size: 100,
                                color:
                                    AppColors.primaryRed.withValues(alpha: 0.3),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                food.category,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.mediumGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Gradient overlay at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.offWhite.withValues(alpha: 0),
                                AppColors.offWhite.withValues(alpha: 0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Food Details Content ──────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Drag Handle ─────────────────────────────
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
                    const SizedBox(height: 20),

                    // ── Name and Rating Row ─────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            food.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkCharcoal,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accentGold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.accentGold,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${food.rating}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkCharcoal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${food.reviewCount} reviews',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mediumGrey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Description ─────────────────────────────
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCharcoal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      food.description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: AppColors.darkCharcoal.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Quantity Selector ───────────────────────
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCharcoal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    QuantitySelector(
                      quantity: _quantity,
                      onIncrease: () {
                        setState(() {
                          if (_quantity < AppConstants.maxCartQuantity) {
                            _quantity++;
                          }
                        });
                      },
                      onDecrease: () {
                        setState(() {
                          if (_quantity > AppConstants.minCartQuantity) {
                            _quantity--;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 32),

                    // ── Price and Add to Cart ────────────────────
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          // Price section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Price',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.mediumGrey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(food.price * _quantity).toInt()} TZS',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryRed,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Add to Cart button
                          SizedBox(
                            width: 180,
                            child: CustomButton(
                              label: 'Add to Cart',
                              icon: Icons.shopping_cart,
                              onPressed: () => _addToCart(context, food),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Adds the food item to the cart with the selected quantity
  void _addToCart(BuildContext context, FoodItem food) {
    context.read<CartProvider>().addToCart(food, quantity: _quantity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_quantity× ${food.name} added to cart',
        ),
        duration: AppConstants.snackbarDuration,
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: AppColors.accentGold,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.cart);
          },
        ),
      ),
    );
  }

  /// Returns an icon for each food category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Burgers':
        return Icons.lunch_dining;
      default:
        return Icons.restaurant;
    }
  }
}
