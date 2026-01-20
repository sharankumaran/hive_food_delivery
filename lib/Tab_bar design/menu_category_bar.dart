// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/model/category_model.dart';

class MenuCategoryBar extends SliverPersistentHeaderDelegate {
  final List<CategoryModel> categories;
  final int selectedIndex;
  final Function(int) onTap;
  final ScrollController _scrollController = ScrollController();

  MenuCategoryBar({
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  }) {
    _scrollToSelected();
  }

  void _scrollToSelected() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        double offset = selectedIndex * 85.0; // Adjusted for new item width
        _scrollController.animateTo(
          (offset - 60).clamp(0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final int visibleCount = categories.length > 7 ? 7 : categories.length;

    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (shrinkOffset > 0)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
        ],
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 1),
        ),
      ),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: visibleCount + 1,
        itemBuilder: (context, index) {
          if (index == visibleCount) return _buildViewAll(context);

          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              width: 85,
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: Colors.transparent,
              child: Column(
                children: [
                  // Swiggy-style circular ring
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFEF4444)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        categories[index].image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categories[index].name,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: -0.3,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF4B5563),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewAll(BuildContext context) {
    return GestureDetector(
      onTap: () => _openAllCategoriesSheet(context),
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Icon(
                Icons.grid_view_rounded,
                size: 22,
                color: Color(0xFFEF4444),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "More",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4B5563),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAllCategoriesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Text(
                  "Explore Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10, // Space between rows
                    crossAxisSpacing: 10, // Space between columns
                    childAspectRatio:
                        0.68, // 🔑 FIXED: Lower value gives more vertical height
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      onTap(index);
                    },
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Prevents taking extra space
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade100),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              categories[index].image,
                              width: 60, // Slightly smaller for safety
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Wrap text to prevent overflow if name is long
                        SizedBox(
                          height: 32, // Fixed height for 2 lines of text
                          child: Text(
                            categories[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
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
  double get maxExtent => 115;
  @override
  double get minExtent => 115;
  @override
  bool shouldRebuild(covariant MenuCategoryBar oldDelegate) => true;
}
