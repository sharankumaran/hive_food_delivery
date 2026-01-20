// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Menu_Section extends StatelessWidget {
  final String title;

  const Menu_Section({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // sample item card
          Container(
            height: 90,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.05)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
