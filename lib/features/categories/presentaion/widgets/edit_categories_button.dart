import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:toastification/toastification.dart';

class CategoriesButtonEdit extends StatelessWidget {
  const CategoriesButtonEdit({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is EditCategorySuccessState) {
          showToastificationWidget(
            message: 'Category Edited successfully',
            context: context,
            notificationType: ToastificationType.success,
          );
          context.pushReplacementNamed(Routes.category);
        } else if (state is EditCategoryFailedState) {
          showToastificationWidget(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is EditCategoryLoadingState) {
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        }
        return CustomButton(
          height: 40,
          onTap: () {
            context.read<CategoriesCubit>().editCategory(
                context: context,
                name: context
                    .read<CategoriesCubit>()
                    .superCategoryNameController
                    .text,
                id: id);
          },
          fontSize: 16,
          isGradient: true,
          borderColor: AppColors.transparent,
          text: 'Edit',
        );
      },
    );
  }
}
