import 'package:flutter/material.dart';

class SafetyInfoSection extends StatelessWidget {
  const SafetyInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Food Safety & Info",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: const [
        ListTile(title: Text("• Prepared in hygienic kitchen")),
        ListTile(title: Text("• Contains dairy & gluten")),
        ListTile(title: Text("• Best consumed within 2 hours")),
        ListTile(title: Text("• FSSAI certified restaurant")),
      ],
    );
  }
}
