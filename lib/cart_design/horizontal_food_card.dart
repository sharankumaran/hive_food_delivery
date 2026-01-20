import 'package:flutter/material.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/model/cart_item_model.dart';
import 'package:provider/provider.dart';

class HorizontalFoodCard extends StatelessWidget {
  final CartItemModel cartitem;
  const HorizontalFoodCard({super.key, required this.cartitem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //imageeeeeeeeeeeeeeeee
        Expanded(
          flex: 3,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(16),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(6),
                child: Center(child: Image.asset('', fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        SizedBox(width: 14),
        //title,,,,,price,,,,size
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text('', overflow: TextOverflow.ellipsis, maxLines: 2),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
