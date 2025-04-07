import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/views_categories_row.dart';

class Categories {
  final String category;

// final String views;
  final String rank;

  Categories({required this.category, required this.rank});
}

class ItemViews extends StatelessWidget {
  const ItemViews({super.key, required this.items});

  final List<ItemsEntities> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Most Viewed Items',
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          15.verticalSpace,
          ...List.generate(
            items.length,
            (index) => ViewsCategories(
              isItem: true,
              category: items[index].name,
              rank: index + 1,
              views: items[index].views.toDouble(), image: items[index].image,
            ),
          )
        ],
      ),
    );
  }
}
