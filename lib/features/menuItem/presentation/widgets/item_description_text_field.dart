import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class ItemDescriptionTextField extends StatelessWidget {
  const ItemDescriptionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: context.read<MenuCubit>().descriptionController,
          title: 'Item Description ( local: English )',
          titleFontSize: 14,
          borderColor: AppColors.containerColor,
          maxLines: 3,
          validator: (value) {
            if (value!.isEmpty) {
              return "please enter Item Description";
            }
            return null;
          },
        );
      },
    );
  }
}
