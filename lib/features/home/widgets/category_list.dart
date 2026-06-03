import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/category_chip.dart';
import '../../../providers/food_provider.dart';

/// Horizontal scrollable list of food category chips.
/// Allows the user to filter food items by category.
class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title with burger icon below
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Image.asset(
                        'lib/assets/images/logo.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Burgers',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryRed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal scrolling chips
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: AppConstants.categories.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.categories[index];
                  return CategoryChip(
                    label: category,
                    isSelected: foodProvider.selectedCategory == category,
                    onTap: () => foodProvider.setCategory(category),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
