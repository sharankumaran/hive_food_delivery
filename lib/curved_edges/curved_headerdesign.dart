// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Circularcontainer extends StatelessWidget {
  const Circularcontainer({super.key, required this.size, required this.child});
  final Size size;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: AlignmentGeometry.bottomRight,
              colors: [Color(0xFFD32F2F), Color(0XFFF44336), Color(0XFFFF6F61)],
            ),
          ),
        ),
        //light glow
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: AlignmentGeometry.topLeft,
              radius: 1,
              colors: [Colors.grey.withOpacity(0.10), Colors.deepOrange],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
