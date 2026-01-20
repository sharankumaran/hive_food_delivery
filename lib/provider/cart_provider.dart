import 'package:flutter/material.dart';
import '../model/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items => _items;

  void addItem(String id, String name, double price, String image) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity++;
    } else {
      _items[id] = CartItemModel(
        id: id,
        name: name,
        price: price,
        image: image,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  void increase(String id) {
    _items[id]!.quantity++;
    notifyListeners();
  }

  void decrease(String id) {
    if (_items[id]!.quantity > 1) {
      _items[id]!.quantity--;
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  int get totalItems => _items.values.fold(0, (sum, e) => sum + e.quantity);

  double get itemTotal =>
      _items.values.fold(0, (sum, e) => sum + e.price * e.quantity);

  double get deliveryFee => _items.isEmpty ? 0 : 30;

  double get grandTotal => itemTotal + deliveryFee;

  double get subTotal => itemTotal;

  String money(double value) => value.toStringAsFixed(2);
}
