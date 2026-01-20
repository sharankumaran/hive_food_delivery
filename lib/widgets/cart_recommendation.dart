// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CartRecommendations extends StatelessWidget {
  const CartRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title("You may also like"),
        const SizedBox(height: 10),
        _horizontalList(),

        const SizedBox(height: 24),

        _title("Frequently bought together"),
        const SizedBox(height: 10),
        _bundleRow(),
      ],
    );
  }

  Widget _title(String t) {
    return Text(
      t,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }

  Widget _horizontalList() {
    final items = [
      "assets/product images/pngwing.com.png",
      "assets/product images/pngwing.com (1).png",
      "assets/product images/delicious-cooked-sea-food.jpg",
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (_, i) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade100,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(items[i], fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _bundleRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.orange.withOpacity(.08),
      ),
      child: Row(
        children: const [
          Icon(Icons.local_fire_department, color: Colors.deepOrange),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Burger + Fries + Coke at ₹199 only",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
