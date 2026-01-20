import 'package:flutter/material.dart';

class EtaBanner extends StatelessWidget {
  const EtaBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: const [
          Icon(Icons.timer, color: Colors.deepOrange),
          SizedBox(width: 10),
          Text(
            "Delivery in 25–30 mins",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
