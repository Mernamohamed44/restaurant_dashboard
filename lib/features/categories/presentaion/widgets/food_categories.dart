import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';

import 'category_list_item.dart';

class FoodCategories extends StatefulWidget {
  const FoodCategories({
    super.key,
  });

  @override
  State<FoodCategories> createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {
  bool isFoodClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomText(
                text: 'Food Categorie',
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 1, // Thickness of the line
                  color: const Color.fromRGBO(115, 129, 141, 0.16),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isFoodClicked = !isFoodClicked;
                    });
                  },
                  child: isFoodClicked
                      ? const Icon(
                          Icons.keyboard_arrow_up,
                          color: AppColors.textColor,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.textColor,
                        ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          isFoodClicked
              ? SizedBox(
                  height: 500,
                  child: LayoutBuilder(builder: (context, constraints) {
                    int crossAxisCount;
                    if (context.screenWidth >= 1600) {
                      crossAxisCount = 5;
                    } else if (context.screenWidth >= 1400) {
                      crossAxisCount = 4;
                    } else if (context.screenWidth >= 1000) {
                      crossAxisCount = 3;
                    } else if (context.screenWidth >= 400) {
                      crossAxisCount = 2;
                    } else {
                      crossAxisCount = 1;
                    }
                    return GridView.builder(
                        itemCount: 5,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (context, index) {
                          return const CategoryListItem();
                        });
                  }),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
