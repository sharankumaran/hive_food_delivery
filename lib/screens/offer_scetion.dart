import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_food_delivery/design_widget/animated_offercard.dart';

class OffersSection extends StatefulWidget {
  const OffersSection({super.key});

  @override
  State<OffersSection> createState() => _OffersSectionState();
}

class _OffersSectionState extends State<OffersSection> {
  final PageController _controller = PageController(viewportFraction: 0.85);
  int _currentIndex = 0;

  final List<Map<String, String>> offers = [
    {
      "title": "15% OFF",
      "subtitle": "On all orders",
      "image":
          "assets/product images/—Pngtree—3d kfc style fried chicken_15683285.png",
    },
    {
      "title": "Free Delivery",
      "subtitle": "Above ₹399",
      "image":
          "assets/product images/—Pngtree—free delivery label in flat_7295905.png",
    },
    {
      "title": "Combo Deal",
      "subtitle": "Meals at ₹299",
      "image": "assets/product images/pngwing.com (2).png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _autoSlide();
  }

  void _autoSlide() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;

      _currentIndex = (_currentIndex + 1) % offers.length;
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Offers"),

        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: _controller,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return AnimatedOfferCard(
                title: offer["title"]!,
                subtitle: offer["subtitle"]!,
                image: offer["image"]!,
              );
            },
          ),
        ),
      ],
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
