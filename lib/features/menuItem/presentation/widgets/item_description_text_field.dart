import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';

class ItemDescriptionTextField extends StatelessWidget {
  const ItemDescriptionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextFormField(
      title: 'Item Description ( local: English )',
      titleFontSize: 14,
      borderColor: AppColors.containerColor,
      maxLines: 3,
    );
  }
}
