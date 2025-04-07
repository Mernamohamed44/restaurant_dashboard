import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:toastification/toastification.dart';

class MenuButtonEdit extends StatelessWidget {
  const MenuButtonEdit({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuState>(
      listener: (context, state) {
        if (state is EditItemSuccessState) {
          showToastificationWidget(
            message: 'Item Edited successfully',
            context: context,
            notificationType: ToastificationType.success,
          );
          context.pushReplacementNamed(Routes.menuItem);
        } else if (state is EditItemFailState) {
          showToastificationWidget(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is EditItemLoadingState) {
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        }
        return CustomButton(
          height: 40,
          onTap: () {
            context.read<MenuCubit>().editItem(id: id);
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
