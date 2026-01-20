// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_food_delivery/screens/phone_verifictaion_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // 🎬 Animation controller for logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Fade animation
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Logo scale
    _scaleAnim = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // ⏳ Auto navigation
    _timer = Timer(const Duration(seconds: 8), goNext);
  }

  void goNext() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PhoneRegistrationScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7C843),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD54F), Color(0XFFFFB300), Color(0XFFFF8F00)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 🔹 SKIP BUTTON
              Positioned(
                top: 16,
                right: 16,
                child: TextButton(
                  onPressed: goNext,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins', // Added font family
                    ),
                  ),
                ),
              ),

              // 🔹 CENTER CONTENT
              Center(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // LOGO with scale animation
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Image.asset(
                          "assets/logos/Logo2-1.png",
                          height: 110,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 🔹 COMPANY NAME
                      const Text(
                        'BRITISH CUISINE',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontFamily: 'Poppins', // Added font family
                        ),
                      ),

                      const SizedBox(height: 6),

                      // 🔹 TAGLINE
                      const Text(
                        'Since 2017',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurpleAccent,
                          fontFamily: 'Poppins', // Added font family
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔹 FOOTER
              const Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "POWERED BY BRITISH HUB",
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins', // Added font family
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
}
