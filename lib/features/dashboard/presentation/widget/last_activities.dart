import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/category_views.dart';

class LatestActivities extends StatelessWidget {
  LatestActivities({
    super.key,
  });

  List<Categories> categories = [
    Categories(
        category: 'Category Update',
        rank:
            'Category “ Salad “ has been renamed “ Fresh Salad “ click Here to view Categories.'),
    Categories(
        category: 'Category Update',
        rank:
            'Category “ Salad “ has been renamed “ Fresh Salad “ click Here to view Categories.'),
    Categories(
        category: 'Category Update',
        rank:
            'Category “ Salad “ has been renamed “ Fresh Salad “ click Here to view Categories.'),
    Categories(
        category: 'Customer Review',
        rank:
            'Category “ Salad “ has been renamed “ Fresh Salad “ click Here to view Categories.'),
    Categories(
        category: 'Customer Review',
        rank:
            'Category “ Salad “ has been renamed “ Fresh Salad “ click Here to view Categories.'),
    Categories(
        category: 'Customer Review',
        rank:
            'Category “ Salad “ has been renamed “ Fresh Salad “ click Here to view Categories.'),
  ];

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
              text: 'Latest Activities',
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: const Divider(
                color: Color.fromRGBO(115, 129, 141, 0.16),
              ),
            ),
            ...List.generate(
              categories.length,
              (index) => LatestActivitiesRow(
                category: categories[index].category,
                update: categories[index].rank,
              ),
            )
          ],
        ));
  }
}

class LatestActivitiesRow extends StatelessWidget {
  const LatestActivitiesRow(
      {super.key, required this.category, required this.update});

  final String category;
  final String update;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            backgroundColor: AppColors.boldContainerColor,
            child: Image.asset(ImageManager.update)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: category,
                color: AppColors.accentContainerColor,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              5.verticalSpace,
              CustomText(
                text: update,
                maxLines: 4,
                color: AppColors.accentContainerColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              const Divider(
                color: Color.fromRGBO(115, 129, 141, 0.16),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        const CustomText(
          text: '3 min',
          color: AppColors.accentContainerColor,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ],
    );
  }
}
