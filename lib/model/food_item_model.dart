class FoodItemModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;

  FoodItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image': image,
    'description': description,
    'price': price,
  };

  factory FoodItemModel.fromMap(Map<dynamic, dynamic> map) {
    return FoodItemModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: map['price'] is int
          ? (map['price'] as int).toDouble()
          : (map['price'] ?? 0.0),
    );
  }
}
