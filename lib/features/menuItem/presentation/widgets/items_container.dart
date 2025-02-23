import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: LayoutBuilder(builder: (context, constraints) {
        int crossAxisCount;
        if (context.screenWidth >= 1280) {
          crossAxisCount = 2;
        } else if (context.screenWidth >= 1400) {
          crossAxisCount = 2;
        } else if (context.screenWidth >= 1000) {
          crossAxisCount = 2;
        } else if (context.screenWidth >= 400) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }
        return GridView.builder(
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              mainAxisExtent: 80,
            ),
            itemBuilder: (context, index) {
              return const ItemsContainer();
            });
      }),
    );
  }
}

class ItemsContainer extends StatelessWidget {
  const ItemsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '20,000',
                  color: AppColors.palePrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                CustomText(
                  text: 'Abo-Shahab Salad',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                Flexible(
                  child: CustomText(
                    text:
                        'Mixed Rocca ,Caesar Fattoush, ArmenianHummus with meat.',
                    color: AppColors.accentContainerColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset(ImageManager.dotIcon)
        ],
      ),
    );
  }
}
