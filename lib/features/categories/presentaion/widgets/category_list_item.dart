import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key});

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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'soup',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: '2 items',
                  color: AppColors.accentContainerColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ),
            const Spacer(),
            Image.asset(ImageManager.dotIcon)
          ],
        ),
      ),
    );
  }
}
