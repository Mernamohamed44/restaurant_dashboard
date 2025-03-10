import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';

import '../../../../app/widget/custom_text_form_field.dart';

class ItemPriceTextField extends StatelessWidget {
  const ItemPriceTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextFormField(
      title: 'Item Price',
      titleFontSize: 14,
      borderColor: AppColors.containerColor,
      maxLines: 1,
    );
  }
}
