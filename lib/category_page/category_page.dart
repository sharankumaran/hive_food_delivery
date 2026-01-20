// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:hive_food_delivery/FOOD_GRID.dart';
import 'package:hive_food_delivery/model/category_model.dart';

class CategoryPage extends StatelessWidget {
  final CategoryModel category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 100),
      itemCount: category.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.70,
      ),
      itemBuilder: (context, index) {
        return FoodGridCard(item: category.items[index]);
      },
    );
  }
}
