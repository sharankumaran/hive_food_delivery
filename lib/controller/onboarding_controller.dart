import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_food_delivery/screens/login_screen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  //variablessssss
  final pageController = PageController();
  Rx<int> currentpageIndex = 0.obs;
  //update current index when page scroll
  void updatePageIndicator(index) => currentpageIndex.value = index;

  //jump to specific dot selected page
  void dotNavigationClick(index) {
    currentpageIndex.value = index;
    pageController.jumpTo(index);
  }

  //update current index and jump to next page
  void nextpage() {
    if (currentpageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('isFirsttime', false);
      Get.offAll(LoginScreen());
    } else {
      int page = currentpageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //update current index and jump to last page
  void skippage() {
    final storage = GetStorage();
    storage.write('isFirsttime', false);
    Get.offAll(() => LoginScreen());
    currentpageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
