import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class ItemNameTextField extends StatelessWidget {
  ItemNameTextField({super.key});

  TextEditingController itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: context.read<MenuCubit>().nameController ,
          title: 'Name ( local: English )',
          titleFontSize: 14,
          borderColor: AppColors.primary,
          validator: (value) {
            if (value!.isEmpty) {
              return "please enter name";
            }
            return null;
          },
        );
      },
    );
  }
}
