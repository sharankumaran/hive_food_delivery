// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/core/constants/theme/color_theme.dart';
import 'package:hive_food_delivery/screens/add_to_cart_screen.dart';
import 'package:provider/provider.dart';

class MiniCartBar extends StatelessWidget {
  const MiniCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        if (cart.items.isEmpty) return const SizedBox();

        return Positioned(
          left: 16,
          right: 16,
          bottom: 70,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddToCartScreen()),
              );
            },
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.secondaryBlue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black.withOpacity(.25),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    "${cart.totalItems} items",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "₹${cart.money(cart.grandTotal)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
