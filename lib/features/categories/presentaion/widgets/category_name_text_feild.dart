import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class CategoryNameTextField extends StatelessWidget {
  const CategoryNameTextField({super.key});


  @override
  Widget build(BuildContext context) {
    return  CustomTextFormField(
      controller: context.read<CategoriesCubit>().categoryNameController,
      title: 'Name ( local: English )',
      titleFontSize: 14,
      borderColor: AppColors.primary,
    );
  }
}
