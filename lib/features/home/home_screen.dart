import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/food_item.dart';
import '../../providers/food_provider.dart';
import '../../providers/cart_provider.dart';
import '../../routes/app_routes.dart';
import 'widgets/banner_widget.dart';
import 'widgets/category_list.dart';
import 'widgets/popular_foods.dart';
import 'widgets/search_bar_widget.dart';

/// Home Screen — the main landing page after splash.
/// Displays a banner, search bar, food categories, popular items,
/// and category-filtered food items.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load food data when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FoodProvider>().loadFoods();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: CustomScrollView(
        slivers: [
          // ── App Bar with Glory Burger branding ────────────────
          SliverAppBar(
            expandedHeight: 60,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryRed,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lunch_dining,
                  color: AppColors.accentGold,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  AppConstants.appName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            actions: [
              // Cart icon with badge
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Consumer<CartProvider>(
                  builder: (context, cart, _) {
                    return Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.cart);
                          },
                        ),
                        if (cart.itemCount > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.accentGold,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '${cart.itemCount}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.nearBlack,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          // ── Main Content ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Promotional banner
                const BannerWidget(),

                const SizedBox(height: 16),

                // Search bar
                SearchBarWidget(
                  controller: _searchController,
                  onChanged: (query) {
                    context.read<FoodProvider>().setSearchQuery(query);
                  },
                  onClear: () {
                    context.read<FoodProvider>().clearSearch();
                  },
                ),

                const SizedBox(height: 20),

                // Category chips
                const CategoryList(),

                const SizedBox(height: 20),

                // Popular food items (horizontal scroll)
                const PopularFoods(),

                const SizedBox(height: 20),

                // Category-filtered food items
                Consumer<FoodProvider>(
                  builder: (context, foodProvider, _) {
                    return _buildCategoryFoods(foodProvider);
                  },
                ),

                const SizedBox(height: 100), // Bottom padding for nav bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the category-filtered food grid section
  Widget _buildCategoryFoods(FoodProvider foodProvider) {
    if (foodProvider.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryRed),
          ),
        ),
      );
    }

    final foods = foodProvider.filteredFoods;
    final category = foodProvider.selectedCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'All $category',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.darkCharcoal,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Food items grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return _buildGridFoodCard(context, food);
            },
          ),
        ),
      ],
    );
  }

  /// Builds an individual food card for the grid layout
  Widget _buildGridFoodCard(BuildContext context, FoodItem food) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.foodDetails,
          arguments: food.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkCharcoal.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image placeholder
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  width: double.infinity,
                  color: AppColors.offWhite,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getCategoryIcon(food.category),
                          size: 36,
                          color: AppColors.primaryRed.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          food.category,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.mediumGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Food info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCharcoal,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${food.price.toInt()} TZS',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryRed,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CartProvider>().addToCart(food);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${food.name} added to cart'),
                                duration: AppConstants.snackbarDuration,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryRed,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
