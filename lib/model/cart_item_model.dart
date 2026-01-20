class CartItemModel {
  final String id;
  final String name;
  final double price;
  int quantity;
  final String image;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.image,
  });
}
