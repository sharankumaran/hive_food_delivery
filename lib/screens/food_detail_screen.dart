import 'package:flutter/material.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/provider/favourite_provider.dart';
import 'package:hive_food_delivery/widgets/add_on_section.dart';
import 'package:hive_food_delivery/widgets/frequently_bought_section.dart';
import 'package:hive_food_delivery/widgets/from_kitchen.dart';
import 'package:hive_food_delivery/widgets/quantity_selector.dart';
import 'package:hive_food_delivery/widgets/rating_stars.dart';
import 'package:hive_food_delivery/widgets/safety_info_section.dart';
import 'package:hive_food_delivery/widgets/similar_items_carousel.dart';
import 'package:hive_food_delivery/widgets/fly_to_cart.dart';
import 'package:provider/provider.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key, required this.item});
  final FoodItemModel item;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavouriteProvider>();
    final cart = context.read<CartProvider>();
    final isFav = fav.isFavourite(widget.item.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      body: Stack(
        children: [
          // ================= IMAGE (PINCH ZOOM) =================
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Hero(
              tag: "food_${widget.item.id}",
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 3,
                child: Image.asset(widget.item.image, fit: BoxFit.cover),
              ),
            ),
          ),

          // BACK
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // FAV
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.deepOrange,
                ),
                onPressed: () => fav.toggleFavourite(widget.item),
              ),
            ),
          ),

          // ================= CONTENT =================
          DraggableScrollableSheet(
            initialChildSize: .65,
            minChildSize: .65,
            maxChildSize: .9,
            builder: (_, controller) {
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
                ),
                child: ListView(
                  controller: controller,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    Text(
                      widget.item.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ⭐ RATINGS
                    const RatingStars(rating: 4),

                    const SizedBox(height: 10),

                    Text(
                      "₹${widget.item.price}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      widget.item.description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ➕➖ QUANTITY
                    QuantitySelector(
                      value: quantity,
                      onChanged: (v) => setState(() => quantity = v),
                    ),

                    const SizedBox(height: 24),

                    // 🛒 ADD TO CART (FLY ANIMATION)
                    FlyToCartButton(
                      onTap: () {
                        cart.addItem(
                          widget.item.id,
                          widget.item.name,
                          widget.item.price * quantity,
                          widget.item.image,
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // 🍔 SIMILAR ITEMS
                    const Text(
                      "Similar Items",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SimilarItemsCarousel(),
                    SizedBox(height: 10),
                    AddonsSection(),
                    SizedBox(height: 10),
                    SafetyInfoSection(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
