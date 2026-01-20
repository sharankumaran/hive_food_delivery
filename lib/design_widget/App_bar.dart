import 'package:flutter/material.dart';
import 'package:hive_food_delivery/screens/favourite_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../provider/favourite_provider.dart';

class App_bar extends StatelessWidget {
  const App_bar({super.key});

  @override
  Widget build(BuildContext context) {
    const Color deepSlate = Color(0xFF1E293B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Deliver to",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Row(
                children: [
                  Text(
                    "Your Location",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ],
          ),

          // --- FAVOURITE ICON WITH POSITIONED BADGE ---
          Consumer<FavouriteProvider>(
            builder: (context, favProv, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Navigate to Favourites Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouriteScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Iconsax.heart,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  if (favProv.totalFavourites > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: deepSlate, // Premium Slate instead of Black
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.orange, width: 1.5),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${favProv.totalFavourites}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
