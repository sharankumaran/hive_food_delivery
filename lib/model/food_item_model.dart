class FoodItemModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;

  // 🔥 NEW – Pro fields
  final bool isVeg;
  final bool isBestseller;
  final bool available;
  final int spiceLevel; // 0–3
  final List<String> variants; // ["Hot", "Iced"]

  FoodItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    this.isVeg = false,
    this.isBestseller = false,
    this.available = true,
    this.spiceLevel = 0,
    this.variants = const [],
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image': image,
    'description': description,
    'price': price,
    'isVeg': isVeg,
    'isBestseller': isBestseller,
    'available': available,
    'spiceLevel': spiceLevel,
    'variants': variants,
  };

  factory FoodItemModel.fromMap(Map<dynamic, dynamic> map) {
    return FoodItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      isVeg: map['isVeg'] ?? false,
      isBestseller: map['isBestseller'] ?? false,
      available: map['available'] ?? true,
      spiceLevel: map['spiceLevel'] ?? 0,
      variants: List<String>.from(map['variants'] ?? []),
    );
  }
}
