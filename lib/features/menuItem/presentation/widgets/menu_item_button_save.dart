import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:toastification/toastification.dart';

class MenuItemButtonSave extends StatelessWidget {
  const MenuItemButtonSave({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuState>(
      builder: (context, state) {
        if (state is AddItemLoadingState) {
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        } else {
          return CustomButton(
            height: 40,
            onTap: () {
              context.read<MenuCubit>().addItem();
            },
            fontSize: 16,
            isGradient: true,
            borderColor: AppColors.transparent,
            text: 'save',
          );
        }
      },
      listener: (BuildContext context, MenuState state) {
        if (state is AddItemSuccessState) {
          showToastificationWidget(
            message: 'Item Added successfully',
            context: context,
            notificationType: ToastificationType.success,
          );
          context.pushReplacementNamed(Routes.menuItem);
        } else if (state is AddItemFailState) {
          showToastificationWidget(
            message: state.message,
            context: context,
          );
        }
      },
    );
  }
}
