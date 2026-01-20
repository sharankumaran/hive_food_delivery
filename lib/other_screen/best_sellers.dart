import 'package:flutter/material.dart';
import 'package:hive_food_delivery/design_widget/compact_food_card.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';

class BestSellersSection extends StatelessWidget {
  const BestSellersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      FoodItemModel(
        id: "1",
        name: "French Fries",
        price: 129,
        image:
            "assets/product images/vecteezy_chicken-wings-with-lemon-and-parsley-on-a-plate-with-a-dip_48783241.png",
        description: "",
      ),
      FoodItemModel(
        id: "2",
        name: "Cheese Burger",
        price: 199,
        image: "assets/product images/pngwing.com (1).png",
        description: "",
      ),
      FoodItemModel(
        id: "3",
        name: "Pasta Italiano",
        price: 249,
        image: "assets/product images/delicious-cooked-sea-food.jpg",
        description: "",
      ),
    ];

    return SizedBox(
      height: 185,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return CompactFoodCard(item: items[i]);
        },
      ),
    );
  }
}
