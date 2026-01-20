import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class FrequentlyBoughtSection extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const FrequentlyBoughtSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Frequently Bought Together",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (_, i) {
              final item = items[i];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(item['image'], fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        children: [
                          Text(
                            item['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("₹${item['price']}"),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {
                              cart.addItem(
                                item['id'],
                                item['name'],
                                item['price'],
                                item['image'],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
