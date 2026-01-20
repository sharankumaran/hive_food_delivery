import 'package:flutter/material.dart';
import 'package:hive_food_delivery/Tab_bar%20design/food_dummy_data.dart';

class ViewAllBottom extends StatelessWidget {
  const ViewAllBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void _openAllCategoriesSheet(
  BuildContext context,
  TabController tabController,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.75,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            child: GridView.builder(
              controller: controller,
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    tabController.animateTo(index);
                  },
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          categories[index].image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        categories[index].name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}
