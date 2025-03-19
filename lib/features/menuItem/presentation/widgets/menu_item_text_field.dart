import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';

class MenuItemTextField extends StatelessWidget {
  MenuItemTextField({super.key});

  TextEditingController itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const CustomTextFormField(
      title: 'Name ( local: English )',
      titleFontSize: 14,
      borderColor: AppColors.primary,
    );
  }
}
