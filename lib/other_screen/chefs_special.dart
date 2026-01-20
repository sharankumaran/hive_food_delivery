import 'package:flutter/material.dart';

class ChefsSpecialSection extends StatelessWidget {
  const ChefsSpecialSection({super.key});

  @override
  Widget build(BuildContext context) {
    final specials = [
      {
        "name": "Signature Crab Masala",
        "img": "assets/product images/delicious-cooked-sea-food.jpg",
      },
      {
        "name": "Gusto D Italia Special",
        "img":
            "assets/product images/pasta-with-tomato-basil-grated-cheese.jpg",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: specials.length,
          itemBuilder: (context, i) {
            return _specialCard(specials[i]["name"]!, specials[i]["img"]!);
          },
        ),
      ],
    );
  }

  Widget _specialCard(String title, String image) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Chef’s Pick",
                  style: TextStyle(color: Colors.orange),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
