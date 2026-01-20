import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  // Global controller to allow Home Screen to trigger movement in Menu Screen
  final PageController menuPageController = PageController();

  void updateCategory(int index, {bool animate = true}) {
    _selectedCategoryIndex = index;

    // If the PageView is active, move it to the new index
    if (menuPageController.hasClients) {
      if (animate) {
        menuPageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        menuPageController.jumpToPage(index);
      }
    }
    notifyListeners();
  }
}
