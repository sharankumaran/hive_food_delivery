// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/provider/favourite_provider.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';
import 'package:hive_food_delivery/screens/add_to_cart_screen.dart';
import 'package:provider/provider.dart';

class CompactFoodCard extends StatelessWidget {
  const CompactFoodCard({super.key, required this.item});
  final FoodItemModel item;

  void _showSnackBar(BuildContext context, Widget content) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: const Color(0xFF1C1C1C),
          duration: const Duration(seconds: 2),
          content: content,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final fav = context.watch<FavouriteProvider>();
    final isFav = fav.isFavourite(item.id);

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(.06),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  item.image,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // ❤️ Favourite
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    final wasFav = isFav;
                    fav.toggleFavourite(item);

                    _showSnackBar(
                      context,
                      Row(
                        children: [
                          Icon(
                            wasFav ? Icons.favorite_border : Icons.favorite,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            wasFav
                                ? "Removed from favourites"
                                : "Added to favourites",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 14,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${item.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cart.addItem(
                          item.id,
                          item.name,
                          item.price,
                          item.image,
                        );

                        _showSnackBar(
                          context,
                          Row(
                            children: [
                              const Icon(
                                Icons.shopping_bag,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  "Added to bag",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const AddToCartScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "VIEW",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: const BoxDecoration(
                          color: Colors.deepOrange,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 16,
                          color: Colors.white,
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
