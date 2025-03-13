import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/views_categories_row.dart';

class Categories {
  final String category;

// final String views;
  final String rank;

  Categories({required this.category, required this.rank});
}

class CategoryViews extends StatelessWidget {
  const CategoryViews({super.key, required this.categories});
  final List <CategoriesEntities> categories;
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
            text: 'Most Viewed Categories',
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          15.verticalSpace,
          ...List.generate(
            categories.length,
            (index) => ViewsCategories(
              category: categories[index].name,
              rank: index+1, views:  categories[index].views,
              
            ),
          )
        ],
      ),
    );
  }
}
