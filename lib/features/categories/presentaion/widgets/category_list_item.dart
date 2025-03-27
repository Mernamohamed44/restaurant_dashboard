import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key, required this.itemSuperCategories});
  final CategoriesEntity itemSuperCategories;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.boldContainerColor,
                child: SvgIcon(
                  icon: ImageManager.noImage,
                  color: AppColors.textColor,
                  height: 25,
                )),
            const SizedBox(
              width: 5,
            ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: itemSuperCategories.name!,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: '${itemSuperCategories.itemsCount} items',
                  color: AppColors.accentContainerColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ),
            Spacer(),
            Image.asset(ImageManager.dotIcon)
          ],
        ),
      ),
    );
  }
}
