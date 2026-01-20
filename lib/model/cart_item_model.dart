class CartItemModel {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
