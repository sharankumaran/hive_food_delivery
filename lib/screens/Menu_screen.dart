// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/Tab_bar%20design/food_dummy_data.dart';
import 'package:hive_food_delivery/Tab_bar%20design/menu_category_bar.dart';
import 'package:hive_food_delivery/category_page/category_page.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/provider/menu_provider.dart';
import 'package:hive_food_delivery/bottom_navigationbar/bottom_navigation.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  // Premium Palette - Removing all pure Black
  static const Color deepSlate = Color(
    0xFF1E293B,
  ); // Professional Dark Gray/Blue
  static const Color mediumSlate = Color(0xFF475569);
  static const Color lightBackground = Color(0xFFF8F9FA);

  @override
  void initState() {
    super.initState();
    // Ensures that if we came from Home Screen, the PageView jumps to the right category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final menuProv = Provider.of<MenuProvider>(context, listen: false);
      if (menuProv.menuPageController.hasClients) {
        menuProv.menuPageController.jumpToPage(menuProv.selectedCategoryIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final menuProv = context.watch<MenuProvider>();

    return Scaffold(
      backgroundColor: lightBackground,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                /// --- APP BAR (Premium Slate Theme) ---
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: false,
                  title: isSearching
                      ? TextField(
                          controller: searchController,
                          autofocus: true,
                          style: const TextStyle(color: deepSlate),
                          decoration: const InputDecoration(
                            hintText: "Search dishes...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        )
                      : const Text(
                          "Our Menu",
                          style: TextStyle(
                            color: deepSlate, // Replaced Black
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                          ),
                        ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        isSearching ? Icons.close : Icons.search,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () =>
                          setState(() => isSearching = !isSearching),
                    ),
                  ],
                ),

                /// --- PRO FILTERS ---
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    height: 55,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildFilterChip(
                          "Veg Only",
                          Icons.fiber_manual_record_rounded,
                          Colors.green,
                        ),
                        _buildFilterChip(
                          "Bestsellers",
                          Icons.local_fire_department,
                          Colors.orange,
                        ),
                        _buildFilterChip("Offers", Icons.percent, Colors.red),
                      ],
                    ),
                  ),
                ),

                /// --- STICKY CATEGORY BAR ---
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MenuCategoryBar(
                    categories: categories,
                    selectedIndex: menuProv.selectedCategoryIndex,
                    onTap: (index) {
                      // 1. Update the Provider index
                      menuProv.updateCategory(index);
                      // 2. Animate the PageView to the selected category
                      if (menuProv.menuPageController.hasClients) {
                        menuProv.menuPageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ];
            },

            /// --- PAGE VIEW (Synced with Category Bar) ---
            body: PageView.builder(
              controller: menuProv.menuPageController,
              onPageChanged: (index) {
                // Sync the header bar (selectedIndex) when swiping manually
                menuProv.updateCategory(index, animate: false);
              },
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryPage(category: categories[index]);
              },
            ),
          ),

          /// --- DYNAMIC "VIEW CART" BAR ---
          if (cart.totalItems > 0)
            Positioned(
              bottom: 120, // Adjusted for better visibility above navigation
              left: 16,
              right: 16,
              child: _buildCartOverlay(context, cart),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
      child: FilterChip(
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: mediumSlate, // Replaced Black
          ),
        ),
        avatar: Icon(icon, color: color, size: 16),
        backgroundColor: Colors.white,
        selected: false,
        pressElevation: 0,
        shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade200)),
        onSelected: (_) {},
      ),
    );
  }

  Widget _buildCartOverlay(BuildContext context, CartProvider cart) {
    return GestureDetector(
      onTap: () {
        final navState = context
            .findAncestorStateOfType<BottomNavigationState>();
        if (navState != null) navState.navigationbar(2);
      },
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1B9C42), // Success Green
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // Using a tinted shadow instead of pure black for a premium look
              color: const Color(0xFF1B9C42).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cart.totalItems} ${cart.totalItems == 1 ? 'ITEM' : 'ITEMS'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  "BD ${cart.itemTotal.toStringAsFixed(3)}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "VIEW CART",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
