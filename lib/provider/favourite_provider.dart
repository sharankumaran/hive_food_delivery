import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/food_item_model.dart';

class FavouriteProvider extends ChangeNotifier {
  static const String boxName = "favouritesBox";

  final List<FoodItemModel> _items = [];

  List<FoodItemModel> get items => _items;

  FavouriteProvider() {
    loadFavourites();
  }

  bool isFavourite(String id) {
    return _items.any((e) => e.id == id);
  }

  Future<void> toggleFavourite(FoodItemModel item) async {
    final box = await Hive.openBox(boxName);

    if (isFavourite(item.id)) {
      _items.removeWhere((e) => e.id == item.id);
      await box.delete(item.id);
    } else {
      _items.add(item);
      await box.put(item.id, item.toMap());
    }

    notifyListeners();
  }

  Future<void> loadFavourites() async {
    final box = await Hive.openBox(boxName);
    _items.clear();

    for (var key in box.keys) {
      final data = box.get(key);

      if (data != null && data is Map) {
        try {
          _items.add(FoodItemModel.fromMap(data));
        } catch (e) {
          debugPrint("Invalid favourite item skipped: $e");
        }
      }
    }

    notifyListeners();
  }

  int get totalFavourites => _items.length;
}
