import 'package:flutter/material.dart';

//////////////////////////////////////////////////
/// BANNER DESIGN
//////////////////////////////////////////////////

class BannerDesign extends StatelessWidget {
  const BannerDesign({super.key, required this.imageurl});
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(imageurl, fit: BoxFit.cover),
      ),
    );
  }
}
