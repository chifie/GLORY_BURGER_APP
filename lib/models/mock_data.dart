import 'food_item.dart';
import 'category.dart';

/// Mock data repository for the entire app.
/// All food items, categories, and initial data are defined here.
/// In a production app, this would be replaced with API calls.
class MockData {
  MockData._();

  // ── Categories ────────────────────────────────────────────────
  static const List<Category> categories = [
    Category(id: 'cat_1', name: 'Burgers', icon: '🍔'),
    Category(id: 'cat_2', name: 'Pizza', icon: '🍕'),
    Category(id: 'cat_3', name: 'Drinks', icon: '🥤'),
    Category(id: 'cat_4', name: 'Fries', icon: '🍟'),
  ];

  // ── Food Items ────────────────────────────────────────────────
  static const List<FoodItem> foodItems = [
    // ── Burgers ─────────────────────────────
    FoodItem(
      id: 'food_1',
      name: 'Glory Classic Burger',
      description:
          'Our signature flame-grilled beef patty with fresh lettuce, tomatoes, pickles, and our secret Glory sauce on a toasted sesame bun.',
      price: 12000,
      category: 'Burgers',
      rating: 4.8,
      reviewCount: 234,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1062/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_2',
      name: 'Double Smash Burger',
      description:
          'Two smashed beef patties with melted cheddar cheese, caramelized onions, and tangy BBQ sauce. Pure indulgence.',
      price: 18000,
      category: 'Burgers',
      rating: 4.9,
      reviewCount: 189,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1063/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_3',
      name: 'Chicken Royale',
      description:
          'Crispy fried chicken breast with mayo, fresh lettuce, and juicy tomatoes on a warm brioche bun.',
      price: 14000,
      category: 'Burgers',
      rating: 4.6,
      reviewCount: 156,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1064/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_4',
      name: 'Spicy Inferno Burger',
      description:
          'Not for the faint-hearted! Habanero-infused patty with jalapeños, pepper jack cheese, and ghost pepper sauce.',
      price: 15000,
      category: 'Burgers',
      rating: 4.3,
      reviewCount: 98,
      isPopular: false,
      imageUrl: 'https://picsum.photos/id/1065/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_5',
      name: 'Veggie Delight Burger',
      description:
          'Plant-based patty with avocado, sprouts, tomato, and herb aioli on a whole wheat bun. Healthy never tasted so good.',
      price: 13000,
      category: 'Burgers',
      rating: 4.4,
      reviewCount: 67,
      isPopular: false,
      imageUrl: 'https://picsum.photos/id/1066/300/200', // Placeholder
    ),

    // ── Pizza ───────────────────────────────
    FoodItem(
      id: 'food_6',
      name: 'Pepperoni Supreme',
      description:
          'Loaded with premium pepperoni, mozzarella cheese, and our house-made tomato sauce on a hand-tossed crust.',
      price: 22000,
      category: 'Pizza',
      rating: 4.7,
      reviewCount: 210,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1067/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_7',
      name: 'BBQ Chicken Pizza',
      description:
          'Tender grilled chicken, smoky BBQ sauce, red onions, bell peppers, and a blend of mozzarella and cheddar.',
      price: 24000,
      category: 'Pizza',
      rating: 4.5,
      reviewCount: 143,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1068/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_8',
      name: 'Margherita Classic',
      description:
          'Fresh mozzarella, San Marzano tomatoes, and fragrant basil on our signature thin crust. Simple perfection.',
      price: 18000,
      category: 'Pizza',
      rating: 4.6,
      reviewCount: 178,
      isPopular: false,
      imageUrl: 'https://picsum.photos/id/1069/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_9',
      name: 'Meat Lovers Pizza',
      description:
          'Pepperoni, Italian sausage, ground beef, and bacon on a thick crust with extra cheese. Carnivore heaven.',
      price: 26000,
      category: 'Pizza',
      rating: 4.8,
      reviewCount: 165,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1070/300/200', // Placeholder
    ),

    // ── Drinks ──────────────────────────────
    FoodItem(
      id: 'food_10',
      name: 'Glory Cola',
      description:
          'Ice-cold cola served in a frosty glass. The perfect companion to any burger.',
      price: 3000,
      category: 'Drinks',
      rating: 4.2,
      reviewCount: 320,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1071/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_11',
      name: 'Fresh Mango Juice',
      description:
          'Freshly squeezed mango juice made from premium Tanzanian mangoes. Sweet and refreshing.',
      price: 5000,
      category: 'Drinks',
      rating: 4.7,
      reviewCount: 95,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1072/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_12',
      name: 'Vanilla Milkshake',
      description:
          'Thick and creamy vanilla milkshake made with real ice cream. A classic treat.',
      price: 7000,
      category: 'Drinks',
      rating: 4.8,
      reviewCount: 187,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1073/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_13',
      name: 'Chocolate Milkshake',
      description:
          'Rich chocolate milkshake blended with premium cocoa and real ice cream. Dessert in a glass.',
      price: 7500,
      category: 'Drinks',
      rating: 4.9,
      reviewCount: 201,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1074/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_14',
      name: 'Sparkling Water',
      description:
          'Crisp, refreshing sparkling water. Zero calories, pure refreshment.',
      price: 2000,
      category: 'Drinks',
      rating: 4.0,
      reviewCount: 56,
      isPopular: false,
      imageUrl: 'https://picsum.photos/id/1075/300/200', // Placeholder
    ),

    // ── Fries ───────────────────────────────
    FoodItem(
      id: 'food_15',
      name: 'Classic Salted Fries',
      description:
          'Golden, crispy fries seasoned with just the right amount of sea salt. The perfect side.',
      price: 5000,
      category: 'Fries',
      rating: 4.5,
      reviewCount: 289,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1076/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_16',
      name: 'Loaded Cheese Fries',
      description:
          'Crispy fries smothered in melted cheddar cheese sauce, crispy bacon bits, and green onions.',
      price: 8000,
      category: 'Fries',
      rating: 4.7,
      reviewCount: 198,
      isPopular: true,
      imageUrl: 'https://picsum.photos/id/1077/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_17',
      name: 'Spicy Peri-Peri Fries',
      description:
          'Crispy fries tossed in our fiery peri-peri seasoning blend. Addictively spicy!',
      price: 6000,
      category: 'Fries',
      rating: 4.4,
      reviewCount: 134,
      isPopular: false,
      imageUrl: 'https://picsum.photos/id/1078/300/200', // Placeholder
    ),
    FoodItem(
      id: 'food_18',
      name: 'Sweet Potato Fries',
      description:
          'Lightly seasoned sweet potato fries served with a honey mustard dipping sauce. A healthier twist.',
      price: 7000,
      category: 'Fries',
      rating: 4.6,
      reviewCount: 112,
      isPopular: false,
      imageUrl: 'https://picsum.photos/id/1079/300/200', // Placeholder
    ),
  ];

  /// Returns food items filtered by category name
  static List<FoodItem> getFoodByCategory(String category) {
    return foodItems.where((item) => item.category == category).toList();
  }

  /// Returns only the popular food items
  static List<FoodItem> get popularItems {
    return foodItems.where((item) => item.isPopular).toList();
  }

  /// Returns food items matching a search query
  static List<FoodItem> searchFood(String query) {
    final lowerQuery = query.toLowerCase();
    return foodItems
        .where((item) =>
            item.name.toLowerCase().contains(lowerQuery) ||
            item.description.toLowerCase().contains(lowerQuery) ||
            item.category.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
