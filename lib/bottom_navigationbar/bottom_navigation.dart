// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/screens/Menu_screen.dart';
import 'package:hive_food_delivery/screens/Profile_screen.dart';
import 'package:hive_food_delivery/screens/add_to_cart_screen.dart';
import 'package:hive_food_delivery/screens/home_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  // ✅ THIS IS THE MAGIC FUNCTION
  // It allows any child (Menu, Cart, Home) to change the global tab
  void navigationbar(int index) {
    setState(() => selectedIndex = index);
  }

  final List<Widget> pages = const [
    HomeScreen(), // Index 0
    MenuScreen(), // Index 1
    AddToCartScreen(), // Index 2
    ProfileScreen(), // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Crucial for the floating nav bar look
      // ✅ IndexedStack keeps the Menu Screen from "reloading" every time you switch
      body: IndexedStack(index: selectedIndex, children: pages),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: navigationbar,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.black38,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Iconsax.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu),
                  label: 'Menu',
                ),

                // Cart Badge Logic
                BottomNavigationBarItem(
                  icon: Consumer<CartProvider>(
                    builder: (_, cart, __) => Badge(
                      label: Text(cart.totalItems.toString()),
                      isLabelVisible: cart.totalItems > 0,
                      child: const Icon(Remix.shopping_bag_line),
                    ),
                  ),
                  label: 'Bag',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Iconsax.user),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
