import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:toastification/toastification.dart';

class CategoriesButtonSave extends StatelessWidget {
  const CategoriesButtonSave({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is AddCategorySuccessState) {
          showToastificationWidget(
            message: 'Category Added successfully',
            context: context,
            notificationType: ToastificationType.success,
          );
          context.pushReplacementNamed(Routes.category);
        } else if (state is AddCategoryFailedState) {
          showToastificationWidget(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is AddCategoryLoadingState) {
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        }
        return CustomButton(
          height: 40,
          onTap: () {
            context.read<CategoriesCubit>().addCategory(
              context: context,
                name: context
                    .read<CategoriesCubit>()
                    .categoryNameController
                    .text);
          },
          fontSize: 16,
          isGradient: true,
          borderColor: AppColors.transparent,
          text: 'save',
        );
      },
    );
  }
}
