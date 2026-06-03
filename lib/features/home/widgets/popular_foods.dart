import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/food_card.dart';
import '../../../models/food_item.dart';
import '../../../providers/food_provider.dart';
import '../../../providers/cart_provider.dart';
import '../../../routes/app_routes.dart';

/// Displays a horizontal scrolling list of popular food items.
/// Each item is shown as a FoodCard with add-to-cart functionality.
class PopularFoods extends StatelessWidget {
  const PopularFoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, _) {
        final popularItems = foodProvider.popularFoods;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Right Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Could navigate to a "See All" screen
                    },
                    child: const Text('See All'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal list of food cards
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: popularItems.length,
                itemBuilder: (context, index) {
                  final food = popularItems[index];
                  return FoodCard(
                    food: food,
                    onTap: () => _navigateToDetails(context, food),
                    onAddToCart: () => _addToCart(context, food),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// Navigates to the food details screen
  void _navigateToDetails(BuildContext context, FoodItem food) {
    Navigator.of(context).pushNamed(
      AppRoutes.foodDetails,
      arguments: food.id,
    );
  }

  /// Adds the food item to the cart with a snackbar confirmation
  void _addToCart(BuildContext context, FoodItem food) {
    final cartProvider = context.read<CartProvider>();
    cartProvider.addToCart(food);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${food.name} added to cart'),
        duration: AppConstants.snackbarDuration,
        action: SnackBarAction(
          label: 'VIEW',
          textColor: AppColors.accentGold,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.cart);
          },
        ),
      ),
    );
  }
}
