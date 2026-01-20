// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/screens/Favourite_screen.dart';
import 'package:hive_food_delivery/screens/add_to_cart_screen.dart';
import 'package:iconsax/iconsax.dart';

class HorizontalFoodCard extends StatefulWidget {
  final String name;
  final String price;
  final String image;

  const HorizontalFoodCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  State<HorizontalFoodCard> createState() => _HorizontalFoodCardState();
}

class _HorizontalFoodCardState extends State<HorizontalFoodCard>
    with SingleTickerProviderStateMixin {
  void _showFavouriteSnackBar(bool added) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,

      // 👇 pushes snackbar above bottom nav
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),

      backgroundColor: Colors.black87,
      duration: const Duration(seconds: 3),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

      content: GestureDetector(
        onTap: () {
          // 👉 Navigate to Favourite screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavouriteScreen()),
          );
        },
        child: Row(
          children: [
            Icon(
              added ? Iconsax.heart5 : Iconsax.heart_slash,
              color: Colors.redAccent,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                added
                    ? "Added to favourites • Tap to view"
                    : "Removed from favourites",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 14,
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  bool isFavourite = false;

  late AnimationController _addController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _addController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _addController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _addController.dispose();
    super.dispose();
  }

  void onAddTap() async {
    await _addController.forward();
    await _addController.reverse();
    // TODO: add to cart logic
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 200, // ✅ fixed height – removes extra space issue
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= IMAGE =================
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.asset(
                    widget.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF43A047),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ================= FAVOURITE BUTTON =================
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() => isFavourite = !isFavourite);
                  _showFavouriteSnackBar(isFavourite);
                },
                child: AnimatedScale(
                  scale: isFavourite ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      isFavourite ? Iconsax.heart5 : Iconsax.heart,
                      color: isFavourite ? Colors.red : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),

            // ================= BOTTOM CURVED BAR =================
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(18),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: GestureDetector(
                    onTap: onAddTap,
                    child: Container(
                      width: 46,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Iconsax.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
