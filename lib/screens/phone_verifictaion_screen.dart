// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_food_delivery/curved_edges/curved_edges.dart';
import 'package:hive_food_delivery/screens/otp_verification_screen.dart';

class PhoneRegistrationScreen extends StatefulWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  State<PhoneRegistrationScreen> createState() =>
      _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  final _controller = TextEditingController();

  String _selectedCountry = 'IN';
  String _dialCode = '+91';
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _validateLocalNumber(String value) {
    if (_selectedCountry == 'IN') {
      return RegExp(r'^[6-9]\d{9}$').hasMatch(value);
    } else {
      return RegExp(r'^5\d{8}$').hasMatch(value);
    }
  }

  void _onCountryChange(String country) {
    setState(() {
      _selectedCountry = country;
      _dialCode = country == 'IN' ? '+91' : '+966';
      _controller.clear();
      _errorText = null;
    });
  }

  String _buildE164() => '$_dialCode${_controller.text.trim()}';

  void _onContinue() {
    final value = _controller.text.trim();

    setState(() {
      _errorText = null;

      if (value.isEmpty) {
        _errorText = "Please enter your mobile number";
      } else if (!_validateLocalNumber(value)) {
        _errorText = _selectedCountry == 'IN'
            ? "Enter a valid 10-digit mobile number"
            : "Enter a valid Saudi number starting with 5";
      }
    });

    if (_errorText == null) {
      final e164 = _buildE164();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Using number: $e164")));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OtpVerificationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            ClipPath(
              clipper: CurvedEdges(),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.13),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/logos/Logo2-1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ================= BODY =================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter your Number.",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // ===== COMBINED FIELD =====
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _errorText == null
                            ? Colors.grey.shade400
                            : Colors.red,
                      ),
                    ),
                    child: Row(
                      children: [
                        // COUNTRY + CODE
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCountry,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'IN',
                                child: Row(
                                  children: [
                                    Text("🇮🇳"),
                                    SizedBox(width: 6),
                                    Text("+91"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'SA',
                                child: Row(
                                  children: [
                                    Text("🇸🇦"),
                                    SizedBox(width: 6),
                                    Text("+966"),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (v) {
                              if (v != null) _onCountryChange(v);
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Container(
                          width: 1,
                          height: 24,
                          color: Colors.grey.shade300,
                        ),

                        const SizedBox(width: 10),

                        // NUMBER INPUT
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            maxLength: _selectedCountry == 'IN' ? 10 : 9,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter mobile number",
                              counterText: "",
                            ),
                            onChanged: (_) {
                              if (_errorText != null) {
                                setState(() => _errorText = null);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== ERROR TEXT =====
                  if (_errorText != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      _errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // ===== CONTINUE BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C7C54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _onContinue,
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
