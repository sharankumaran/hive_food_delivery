// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_food_delivery/core/constants/theme/color_theme.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key, required this.item});
  final FoodItemModel item;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;
  String? _selectedVariant;
  final TextEditingController _instructionController = TextEditingController();

  final List<Map<String, dynamic>> _extraToppings = [
    {"name": "Extra Cheese", "price": 45.0, "isSelected": false},
    {"name": "Grilled Mushrooms", "price": 35.0, "isSelected": false},
    {"name": "Spicy Jalapenos", "price": 25.0, "isSelected": false},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.item.variants.isNotEmpty) {
      _selectedVariant = widget.item.variants.first;
    }
  }

  double _calculateTotalPrice() {
    double toppingsTotal = _extraToppings
        .where((t) => t["isSelected"] == true)
        .fold(0.0, (sum, item) => sum + (item["price"] as double));

    return (widget.item.price + toppingsTotal) * quantity;
  }

  @override
  void dispose() {
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavouriteProvider>();
    final cart = context.read<CartProvider>();
    final isFav = fav.isFavourite(widget.item.id);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // --- UPDATED IMAGE SECTION TO MATCH SAMPLE ---
              SliverAppBar(
                expandedHeight: 350,
                automaticallyImplyLeading: false,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Hero(
                          tag: "food_${widget.item.id}",
                          child: Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape
                                  .circle, // Matching the rounded feel of the burger
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              widget.item.image,
                              fit: BoxFit
                                  .contain, // Keeps image centered and uncropped
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // --- REMAINING CONTENT (UNCHANGED) ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildVegBadge(widget.item.isVeg),
                          if (widget.item.isBestseller) ...[
                            const SizedBox(width: 8),
                            _buildBestsellerBadge(),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Remix.star_fill,
                            color: Color(0xFFFFB800),
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "4.9",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            Remix.time_line,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "26 mins",
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.item.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Variant, Toppings, and Instructions Logic
                      if (widget.item.variants.isNotEmpty) ...[
                        const Text(
                          "Select Variant",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildVariantPicker(),
                        const SizedBox(height: 30),
                      ],
                      const Text(
                        "Add-ons",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ..._extraToppings
                          .map((topping) => _buildToppingTile(topping))
                          .toList(),
                      const SizedBox(height: 20),
                      const Text(
                        "Special Instructions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInstructionField(),
                      const SizedBox(height: 130),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Top Navigation Icons
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(
                  Remix.arrow_left_s_line,
                  () => Navigator.pop(context),
                ),
                _buildCircleButton(
                  isFav ? Remix.heart_fill : Remix.heart_line,
                  () {
                    HapticFeedback.lightImpact();
                    fav.toggleFavourite(widget.item);
                  },
                  color: isFav ? AppColors.primaryRed : Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomCheckoutBar(cart),
    );
  }

  // --- UI Helpers (Unchanged from original logic) ---

  Widget _buildCircleButton(
    IconData icon,
    VoidCallback onTap, {
    Color color = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  Widget _buildVariantPicker() {
    return SizedBox(
      height: 46,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.item.variants.length,
        itemBuilder: (context, index) {
          final variant = widget.item.variants[index];
          final isSelected = _selectedVariant == variant;
          return GestureDetector(
            onTap: () => setState(() => _selectedVariant = variant),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryRed : AppColors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected ? AppColors.primaryRed : AppColors.border,
                ),
              ),
              child: Center(
                child: Text(
                  variant,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToppingTile(Map<String, dynamic> topping) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      activeColor: AppColors.primaryRed,
      title: Text(topping["name"]),
      secondary: Text(
        "+ ₹${topping["price"]}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      value: topping["isSelected"],
      onChanged: (v) => setState(() => topping["isSelected"] = v),
    );
  }

  Widget _buildInstructionField() {
    return TextField(
      controller: _instructionController,
      decoration: InputDecoration(
        hintText: "E.g. No mayo...",
        filled: true,
        fillColor: AppColors.backgroundgrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBottomCheckoutBar(CartProvider cart) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundgrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildQtyBtn(Remix.subtract_line, () {
                  if (quantity > 1) setState(() => quantity--);
                }),
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      "$quantity",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                _buildQtyBtn(Remix.add_line, () => setState(() => quantity++)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  for (int i = 0; i < quantity; i++) {
                    cart.addItem(
                      widget.item.id,
                      widget.item.name,
                      _calculateTotalPrice() / quantity,
                      widget.item.image,
                    );
                  }
                  _showSuccessSnackBar(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add to Bag",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "₹${_calculateTotalPrice().toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVegBadge(bool isVeg) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: isVeg ? Colors.green : Colors.red,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.circle,
        color: isVeg ? Colors.green : Colors.red,
        size: 8,
      ),
    );
  }

  Widget _buildBestsellerBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFE0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Remix.flashlight_fill, size: 12, color: Color(0xFFD97706)),
          SizedBox(width: 4),
          Text(
            "BESTSELLER",
            style: TextStyle(
              color: Color(0xFFD97706),
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 20, color: AppColors.textPrimary),
    );
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Remix.checkbox_circle_fill, color: Colors.greenAccent),
              SizedBox(width: 12),
              Text(
                "Item added to bag",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
