import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';

class MenuItemButtonSave extends StatelessWidget {
  const MenuItemButtonSave({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 40,
      onTap: () {},
      fontSize: 16,
      isGradient: true,
      borderColor: AppColors.transparent,
      text: 'save',
    );
  }
}
