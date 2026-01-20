import 'package:flutter/material.dart';

class SimilarItemsCarousel extends StatelessWidget {
  const SimilarItemsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      "assets/product images/pngwing.com.png",
      "assets/product images/pngwing.com (1).png",
      "assets/product images/delicious-cooked-sea-food.jpg",
    ];

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (_, i) {
          return Container(
            width: 130,
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
                    child: Image.asset(images[i], fit: BoxFit.cover),
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
}
