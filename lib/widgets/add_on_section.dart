import 'package:flutter/material.dart';

class AddonsSection extends StatefulWidget {
  const AddonsSection({super.key});

  @override
  State<AddonsSection> createState() => _AddonsSectionState();
}

class _AddonsSectionState extends State<AddonsSection> {
  final Map<String, double> addons = {
    "Extra Cheese": 40,
    "Cold Drink": 30,
    "French Fries": 60,
  };

  final Set<String> selected = {};

  double get total => selected.fold(0, (sum, e) => sum + addons[e]!);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add-ons",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        ...addons.entries.map((e) {
          return CheckboxListTile(
            value: selected.contains(e.key),
            title: Text(e.key),
            subtitle: Text("+ ₹${e.value}"),
            onChanged: (v) {
              setState(() {
                v! ? selected.add(e.key) : selected.remove(e.key);
              });
            },
          );
        }),

        if (selected.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              "Add-ons total: ₹$total",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
      ],
    );
  }
}
