// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/provider/favourite_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FoodGridCard extends StatefulWidget {
  const FoodGridCard({super.key, required this.item});
  final FoodItemModel item;

  @override
  State<FoodGridCard> createState() => _FoodGridCardState();
}

class _FoodGridCardState extends State<FoodGridCard>
    with SingleTickerProviderStateMixin {
  bool showLottie = false;

  // Animation logic
  void playAddAnimation() async {
    setState(() => showLottie = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) setState(() => showLottie = false);
  }

  // Toast logic
  void showProToast({
    required String message,
    required IconData icon,
    Color iconColor = Colors.white,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    final double topPadding = MediaQuery.of(context).padding.top;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - (topPadding + 180),
            left: 30,
            right: 30,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: const Duration(seconds: 2),
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white12, width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 18),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // We call the builder function here
    return _buildMenuGridCard(widget.item);
  }

  // Moved INSIDE the State class so it can access variables and context
  Widget _buildMenuGridCard(FoodItemModel item) {
    const Color deepSlate = Color(0xFF1E293B);
    const Color mediumSlate = Color(0xFF475569);

    final cart = context.read<CartProvider>();
    final fav = context.watch<FavouriteProvider>();
    final isFav = fav.isFavourite(item.id);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: deepSlate.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. IMAGE SECTION
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFF8F9FA),
                  ),
                ),
                Center(
                  child: Hero(
                    tag: 'menu-item-${item.id}',
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(item.image, fit: BoxFit.contain),
                    ),
                  ),
                ),

                // ❤️ Favourite Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      fav.toggleFavourite(item);
                      showProToast(
                        icon: isFav ? Icons.favorite_border : Icons.favorite,
                        iconColor: isFav ? Colors.white : Colors.redAccent,
                        message: isFav
                            ? "Removed from Wishlist"
                            : "Saved to Wishlist",
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),

                // ✨ Lottie Animation
                if (showLottie)
                  Positioned.fill(
                    child: Center(
                      child: Lottie.asset(
                        "assets/lottie/Shopping Cart Loader.json",
                        width: 80,
                        repeat: false,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // 2. INFO SECTION
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: deepSlate,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "Chef's Special",
                  style: TextStyle(
                    color: mediumSlate.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "BD ${item.price.toStringAsFixed(3)}",
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // ➕ Add to Cart Button
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        cart.addItem(
                          item.id,
                          item.name,
                          item.price,
                          item.image,
                        );
                        playAddAnimation();
                        showProToast(
                          message: "Added to bag",
                          icon: Icons.check_circle_rounded,
                          iconColor: const Color(0xFF00A651),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: deepSlate,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
