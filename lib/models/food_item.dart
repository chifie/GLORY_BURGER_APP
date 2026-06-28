/// Represents a single food item on the menu.
/// Each item belongs to a category and has full details for display.
class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String subCategory; // e.g. 'Classic', 'Specialty', 'Premium'
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isPopular;
  final bool isAvailable;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.subCategory = '',
    this.imageUrl = '',
    this.rating = 4.0,
    this.reviewCount = 0,
    this.isPopular = false,
    this.isAvailable = true,
  });

  /// Deserializes a FoodItem from a backend JSON map.
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      category: json['category']?.toString() ?? 'Burgers',
      subCategory: json['subCategory']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      rating: double.tryParse(json['rating']?.toString() ?? '4.0') ?? 4.0,
      reviewCount: int.tryParse(json['reviewCount']?.toString() ?? '0') ?? 0,
      isPopular: json['isPopular'] == true,
      isAvailable: json['isAvailable'] != false,
    );
  }

  /// Serializes a FoodItem to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'subCategory': subCategory,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'isPopular': isPopular,
      'isAvailable': isAvailable,
    };
  }

  /// Creates a copy with optional field overrides
  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? subCategory,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    bool? isPopular,
    bool? isAvailable,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isPopular: isPopular ?? this.isPopular,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
