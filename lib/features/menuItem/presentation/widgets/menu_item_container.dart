import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

class MenuItemContainer extends StatelessWidget {
  const MenuItemContainer(
      {super.key, required this.text, this.isSelected = false});

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        padding: const EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: 4,
          right: 10,
        ),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.containerColor,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            CircleAvatar(
                radius: 18,
                backgroundColor: isSelected
                    ? const Color.fromRGBO(255, 255, 255, 0.24)
                    : AppColors.boldContainerColor,
                child: SvgIcon(
                  icon: ImageManager.noImage,
                  color: isSelected ? AppColors.white : AppColors.textColor,
                  height: 20,
                )),
            const SizedBox(
              width: 5,
            ),
            CustomText(
              text: text,
              color: isSelected ? AppColors.white : AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
