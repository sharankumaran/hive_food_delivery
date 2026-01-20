// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/provider/favourite_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../model/food_item_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  // Theme Colors
  static const Color deepSlate = Color(0xFF1E293B);
  static const Color lightBackground = Color(0xFFF8F9FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: deepSlate, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Favourites",
          style: TextStyle(
            color: deepSlate,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: Consumer<FavouriteProvider>(
        builder: (context, favProv, child) {
          // Check if the list is empty
          if (favProv.items.isEmpty) {
            return _buildEmptyState();
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            itemCount: favProv.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = favProv.items[index];
              return _buildFavouriteCard(context, item, favProv);
            },
          );
        },
      ),
    );
  }

  // Widget to display when no favorites exist
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.heart_slash, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text(
            "No Favourites Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: deepSlate,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Tap the heart icon on any food\nto see it here.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // The Grid Card (Styled to match your Menu/Home screen)
  Widget _buildFavouriteCard(
    BuildContext context,
    FoodItemModel item,
    FavouriteProvider favProv,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: deepSlate.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                    width: 80,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: deepSlate,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BD ${item.price.toStringAsFixed(3)}",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Iconsax.add_circle5,
                          color: Colors.orange,
                          size: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Remove button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => favProv.toggleFavourite(item),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.heart5, color: Colors.red, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
