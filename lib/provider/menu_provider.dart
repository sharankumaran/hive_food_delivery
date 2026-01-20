import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  /// Selected category index for sticky tab bar
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  /// Page controller for syncing PageView
  final PageController menuPageController = PageController();

  /// Update category from tap or swipe
  void updateCategory(int index, {bool animate = true}) {
    _selectedCategoryIndex = index;

    if (animate && menuPageController.hasClients) {
      menuPageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    menuPageController.dispose();
    super.dispose();
  }
}
