// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/bottom_navigationbar/bottom_navigation.dart';
import 'package:hive_food_delivery/cart_design/cart_item_card.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/coupon_section/coupon_section.dart';
import 'package:hive_food_delivery/coupon_section/delivery_eta_banner.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black,
          ),
          onPressed: () {
            final navState = context
                .findAncestorStateOfType<BottomNavigationState>();
            navState?.navigationbar(1);
          },
        ),
        title: const Text(
          "My Bag",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: cart.items.isEmpty
          ? _buildEmptyState(context)
          : _buildCartContent(context, cart),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : _buildDubaiCheckoutBar(cart),
    );
  }

  Widget _buildCartContent(BuildContext context, CartProvider cart) {
    final items = cart.items.values.toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      children: [
        const SizedBox(height: 12),
        const EtaBanner(), // Your existing delivery time banner
        const SizedBox(height: 16),

        /// --- 1. SELECTED DISHES ---
        _buildSectionHeader("Items Selected", Remix.shopping_bag_3_line),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: items.map((e) => CartItemCard(item: e)).toList(),
          ),
        ),

        const SizedBox(height: 25),

        /// --- 2. PREMIUM UPSELL: DRINKS & DESSERTS ---
        _buildSectionHeader("Complete Your Meal", Remix.cup_line),
        _buildUpsellSection(),

        const SizedBox(height: 25),
        const CouponSection(),

        const SizedBox(height: 20),
        _buildInstructionTile(),

        const SizedBox(height: 25),

        /// --- 3. DUBAI STANDARDS: HYGIENE & TRUST ---
        _buildDubaiTrustSection(),

        const SizedBox(height: 25),
        _buildDetailedBill(cart),

        const SizedBox(height: 20),
        _buildPolicyNote(),
        const SizedBox(height: 40),
      ],
    );
  }

  /// --- 🥤 DRINKS & DESSERTS HORIZONTAL LIST ---
  Widget _buildUpsellSection() {
    // This simulates the "Drinks/Desserts" the user might want
    final upsellItems = [
      {'name': 'Fresh Orange Juice', 'price': '25', 'img': 'orange_juice'},
      {'name': 'Chocolate Lava Cake', 'price': '35', 'img': 'cake'},
      {'name': 'Baklava Duo', 'price': '30', 'img': 'baklava'},
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: upsellItems.length,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Remix.image_line, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  upsellItems[index]['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AED ${upsellItems[index]['price']}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.add_circle, color: Colors.black, size: 20),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// --- 🇦E DUBAI TRUST SECTION ---
  Widget _buildDubaiTrustSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          _trustItem(
            Remix.shield_user_line,
            "Municipality Approved Hygiene Standards",
            Colors.green,
          ),
          const Divider(height: 20),
          _trustItem(
            Remix.hand_coin_line,
            "Contactless Delivery Available",
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _trustItem(IconData icon, String title, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  /// --- 💰 PREMIUM CHECKOUT BAR (AED Currency) ---
  Widget _buildDubaiCheckoutBar(CartProvider cart) {
    double taxes = cart.itemTotal * 0.05; // 5% VAT in UAE
    double platformFee = 2.00;
    double finalTotal = cart.grandTotal + platformFee + taxes;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AED ${finalTotal.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    "Incl. 5% VAT",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 52,
              width: 170,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Sleek black button for Dubai luxury feel
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER UI METHODS (REMAINING) ---
  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Remix.chat_history_line, color: Colors.orange, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Add a note for the kitchen...",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Icon(Icons.add_circle_outline, color: Colors.deepOrange, size: 20),
        ],
      ),
    );
  }

  Widget _buildDetailedBill(CartProvider cart) {
    double taxes = cart.itemTotal * 0.05;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _billRow("Subtotal", "AED ${cart.itemTotal.toStringAsFixed(2)}"),
          _billRow(
            "Delivery Fee",
            "AED ${cart.deliveryFee.toStringAsFixed(2)}",
            valueColor: Colors.blue,
          ),
          _billRow("VAT (5%)", "AED ${taxes.toStringAsFixed(2)}"),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Pay",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              Text(
                "AED ${(cart.grandTotal + 2.00 + taxes).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billRow(
    String label,
    String value, {
    Color valueColor = Colors.black87,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyNote() {
    return const Center(
      child: Text(
        "By placing the order, you agree to our Terms of Service",
        style: TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Remix.shopping_cart_line, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "Your bag is empty",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => context
                .findAncestorStateOfType<BottomNavigationState>()
                ?.navigationbar(1),
            child: const Text(
              "Start Shopping",
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
