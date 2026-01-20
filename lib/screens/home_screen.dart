// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_food_delivery/Tab_bar%20design/food_dummy_data.dart';
import 'package:hive_food_delivery/bottom_navigationbar/bottom_navigation.dart';
import 'package:hive_food_delivery/model/food_item_model.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_food_delivery/curved_edges/curved_edges.dart';
import 'package:hive_food_delivery/design_widget/App_bar.dart';
import 'package:hive_food_delivery/provider/menu_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _floatingController;
  int _chefChoiceIndex = 0;
  late Timer _chefTimer;
  late List<dynamic> _chefPicks;
  bool _isLoading = true;

  // BRAND COLOR PALETTE (From British Hub Logo)
  static const Color britishRed = Color(0xFFD91F26); // Logo Red
  static const Color britishBlue = Color(0xFF163172); // Logo Navy Blue
  static const Color britishWhite = Colors.white;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _chefPicks = (categories.expand((c) => c.items).toList()..shuffle())
        .take(5)
        .toList();

    _chefTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _chefChoiceIndex = (_chefChoiceIndex + 1) % _chefPicks.length;
        });
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _chefTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allItems = categories.expand((cat) => cat.items).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA), // Slightly cooler grey
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. HEADER (Color updated to British Blue)
          SliverToBoxAdapter(
            child: ClipPath(
              clipper: CurvedEdges(),
              child: Container(
                color: britishBlue, // Changed from Orange to British Navy Blue
                height: 380,
                child: Column(
                  children: [
                    const App_bar(),
                    _buildSearchBar(),
                    _buildFlashOffer(),
                  ],
                ),
              ),
            ),
          ),

          // 2. CATEGORY SECTION
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 15),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle("What's on your mind?", ""),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 115,
              child: _isLoading
                  ? _buildCategoryShimmer()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return GestureDetector(
                          onTap: () {
                            final menuProvider = context.read<MenuProvider>();
                            menuProvider.updateCategory(index);
                            if (menuProvider.menuPageController.hasClients) {
                              menuProvider.menuPageController.jumpToPage(index);
                            }
                            final navState = context
                                .findAncestorStateOfType<
                                  BottomNavigationState
                                >();
                            if (navState != null) navState.navigationbar(1);
                          },
                          child: Container(
                            width: 75,
                            margin: const EdgeInsets.only(
                              right: 15,
                              top: 5,
                              bottom: 5,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: britishBlue.withOpacity(0.1),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: britishBlue.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Hero(
                                        tag: 'cat-${cat.name}',
                                        child: Image.asset(
                                          cat.image,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cat.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: britishBlue, // Muted blue for text
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),

          // 3. CHEF'S CHOICE (Colors updated to Red/Blue Gradient)
          SliverToBoxAdapter(
            child: _isLoading ? _buildChefShimmer() : _buildLiveChefChoice(),
          ),

          // 4. POPULAR GRID
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle("Our Signature Menu", "Full Menu"),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: _isLoading
                ? _buildGridShimmer()
                : SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.8,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildMenuGridCard(allItems[index]),
                      childCount: 4,
                    ),
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildFlashOffer() {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FLAT",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                Text(
                  "50% OFF",
                  style: TextStyle(
                    fontSize: 30,
                    color: britishRed, // Accent Red for Offer
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          // Food images remain untouched as per your request
          Positioned(
            bottom: 40,
            left: 210,
            right: 7,
            child: _AnimatedFoodItem(
              controller: _floatingController,
              angle: 0.2,
              imageWidth: 90,
              imagePath:
                  'assets/food images/d84c34d5-b2c0-4b31-bf08-b3d734cba64e-removebg-preview.png',
            ),
          ),
          Positioned(
            right: 80,
            top: 30,
            child: _AnimatedFoodItem(
              controller: _floatingController,
              angle: -0.15,
              imageWidth: 150,
              imagePath:
                  'assets/food images/ada00ee6-6a81-4637-86dd-a8d0d7fbe9de-removebg-preview.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveChefChoice() {
    final currentItem = _chefPicks[_chefChoiceIndex];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: 200,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Gradient (Logo Red to Deep Blue)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [britishRed, britishBlue], // MIXED RED AND BLUE
              ),
              boxShadow: [
                BoxShadow(
                  color: britishBlue.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: britishWhite.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: britishWhite.withOpacity(0.5),
                          ),
                        ),
                        child: const Text(
                          "BRITISH HUB SPECIAL",
                          style: TextStyle(
                            color: britishWhite,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currentItem.name,
                        style: const TextStyle(
                          color: britishWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "BD ${currentItem.price.toStringAsFixed(3)}",
                        style: const TextStyle(
                          color: britishWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                // Food animation remains the same
                Expanded(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        currentItem.image,
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGridCard(FoodItemModel item) {
    final cart = context.watch<CartProvider>();
    final fav = context.watch<FavouriteProvider>();

    final bool isInCart = cart.items.containsKey(item.id);
    final bool isFav = fav.isFavourite(item.id);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: britishBlue.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE + FAV ICON
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Center(
                  child: Hero(
                    tag: 'menu-item-${item.id}',
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(item.image, fit: BoxFit.contain),
                    ),
                  ),
                ),

                /// ❤️ FAVOURITE BUTTON (TOP RIGHT)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      fav.toggleFavourite(item);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              isFav
                                  ? "Removed from favourites"
                                  : "Added to favourites",
                            ),
                            duration: const Duration(milliseconds: 800),
                            backgroundColor: britishBlue,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// DETAILS
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: britishBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BD ${item.price.toStringAsFixed(3)}",
                      style: const TextStyle(
                        color: britishRed,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),

                    /// ➕ ADD TO CART BUTTON
                    GestureDetector(
                      onTap: () {
                        if (!isInCart) {
                          context.read<CartProvider>().addItem(
                            item.id,
                            item.name,
                            item.price,
                            item.image,
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("${item.name} added to cart"),
                                duration: const Duration(milliseconds: 900),
                                backgroundColor: britishBlue,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isInCart ? britishRed : britishBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isInCart ? Icons.check : Icons.add,
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

  Widget _buildSectionTitle(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: britishBlue,
          ),
        ),
        if (action.isNotEmpty)
          TextButton(
            onPressed: () {},
            child: Text(
              action,
              style: const TextStyle(
                color: britishRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Iconsax.search_normal_1, size: 20, color: Colors.grey),
          SizedBox(width: 10),
          Text("Search for food...", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Shimmer methods remain largely the same, just keeping the class complete
  Widget _buildCategoryShimmer() =>
      const Center(child: CircularProgressIndicator());
  Widget _buildChefShimmer() => Container(height: 180, color: Colors.grey[200]);
  Widget _buildGridShimmer() => const SliverToBoxAdapter(child: SizedBox());
}

class _AnimatedFoodItem extends StatelessWidget {
  final AnimationController controller;
  final String imagePath;
  final double angle;
  final double imageWidth;
  const _AnimatedFoodItem({
    required this.controller,
    required this.imagePath,
    required this.angle,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, controller.value * 15),
        child: Transform.rotate(
          angle: angle,
          child: Image.asset(imagePath, width: imageWidth),
        ),
      ),
    );
  }
}
