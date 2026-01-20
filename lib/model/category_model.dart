import 'package:hive_food_delivery/model/food_item_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final int order;
  final List<FoodItemModel> items;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.items,
    this.order = 0,
  });
}
