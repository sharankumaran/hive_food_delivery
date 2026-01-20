import 'package:hive_food_delivery/model/food_item_model.dart';

class CategoryModel {
  final String name;
  final String image;
  final List<FoodItemModel> items;
  CategoryModel({required this.name, required this.image, required this.items});
}
