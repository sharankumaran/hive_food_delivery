import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_food_delivery/controller/onboarding_controller.dart';
import 'package:hive_food_delivery/screens/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          //horizontal pagessssssss
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Lottie.asset(height: 550, 'assets/animation/loading.json'),
                    Text(
                      textAlign: TextAlign.center,
                      'Choose Your Food',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome to the world of Food Delivery App of Agm Services',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              //2nd pageeeeeeeeee
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Lottie.asset(
                      height: 550,
                      'assets/animation/Eating Fast food.json',
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Choose Your Food',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome to the world of Food Delivery App of Agm Services',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              //3rd pageeeeeeeeeeeee
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Lottie.asset(
                      height: 550,
                      'assets/animation/Restaurant.json',
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Choose Your Food',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome to the world of Food Delivery App of Agm Services',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //skip button
          Positioned(
            top: 56,
            right: 25,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text('Skip', style: TextStyle(fontSize: 20)),
            ),
          ),
          //dot navigation pause button
          Positioned(
            bottom: 56 + 25,
            left: 26,
            child: SmoothPageIndicator(
              controller: controller.pageController,
              onDotClicked: controller.dotNavigationClick,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotHeight: 5,
              ),
            ),
          ),

          //circular button
          Positioned(
            bottom: 70,
            right: 26,
            child: ElevatedButton(
              onPressed: () => OnboardingController.instance.nextpage(),
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
