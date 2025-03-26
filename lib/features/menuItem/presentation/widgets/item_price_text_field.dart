import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

import '../../../../app/widget/custom_text_form_field.dart';

class ItemPriceTextField extends StatelessWidget {
  const ItemPriceTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
      return CustomTextFormField(
        controller: context.read<MenuCubit>().priceController,
        title: 'Item Price',
        titleFontSize: 14,
        borderColor: AppColors.containerColor,
        maxLines: 1,
        validator: (value) {
          if (value!.isEmpty) {
            return "please enter Item Price";
          }
          return null;
        },
      );
    });
  }
}
