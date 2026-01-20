import 'package:flutter/material.dart';
import 'package:hive_food_delivery/core/constants/theme/color_theme.dart';

class Tab_Bar extends StatelessWidget implements PreferredSizeWidget {
  const Tab_Bar({super.key, required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TabBar(
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        indicatorColor: AppColors.primaryRed,
        unselectedLabelColor: AppColors.backgroundgrey,
        labelColor: AppColors.textPrimary,
        tabs: tabs,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
