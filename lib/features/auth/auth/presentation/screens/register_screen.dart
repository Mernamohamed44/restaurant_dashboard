import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/cubit/register/register_states.dart';

import '../cubit/register/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("screenWidth ${context.screenWidth}");

    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: const RegisterBody(),
    );
  }
}

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: context.screenWidth >= 600 ? RegisterRow() : RegisterColumn(),
    );
  }
}

class RegisterRow extends StatelessWidget {
  const RegisterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.screenHeight * .2,
                  ),
                  const CustomText(
                    text: 'Create New Account',
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                  const CustomText(
                    text:
                        'Nice to see you here, Let’s create a new free account in just few seconds.',
                    color: AppColors.grey73818D99,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  const Divider(
                    color: Color.fromRGBO(115, 129, 141, 0.16),
                  ),
                  10.verticalSpace,
                  RegisterTextFields(),
                  20.verticalSpace,
                  const Divider(
                    color: Color.fromRGBO(115, 129, 141, 0.16),
                  ),
                  25.verticalSpace,
                  RegisterButtons(),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: Image.asset(
          ImageManager.authWeb,
          height: 1.sh,
          fit: BoxFit.cover,
        ))
      ],
    );
  }
}

class RegisterColumn extends StatelessWidget {
  const RegisterColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(ImageManager.authMobile,
              width: double.infinity, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                FittedBox(
                  child: const CustomText(
                    text: 'Create New Account',
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const CustomText(
                  text:
                      'Nice to see you here, Let’s create a new free account in just few seconds.',
                  color: AppColors.grey73818D99,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  maxLines: 4,
                ),
                const Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                10.verticalSpace,
                RegisterTextFields(),
                25.verticalSpace,
                RegisterButtons(),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterTextFields extends StatelessWidget {
  const RegisterTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Column(
      children: [
        CustomTextFormField(
          title: 'Full Name',
          titleFontSize: 14,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter  Full Name ';
            }
            return null;
          },
        ),
        10.verticalSpace,
        CustomTextFormField(
          title: ' Email Address or Phone Number',
          titleFontSize: 14,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Email Address or Phone Number ';
            }
            return null;
          },
        ),
        10.verticalSpace,
        BlocBuilder<RegisterCubit, RegisterStates>(
          builder: (context, state) {
            return CustomTextFormField(
              maxLines: 1,
              title: 'Password',
              titleFontSize: 14,
              suffixIcon: SizedBox(
                height: 0.02.sh,
                child: GestureDetector(
                  onTap: () {
                    cubit.changeVisibility();
                  },
                  child: Icon(
                    cubit.isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.grey73818D99,
                  ),
                ),
              ),
              obscureText: cubit.isObscure,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
            );
          },
        ),
        10.verticalSpace,
        BlocBuilder<RegisterCubit, RegisterStates>(
          builder: (context, state) {
            return CustomTextFormField(
              maxLines: 1,
              title: 'Enter Password Again',
              titleFontSize: 14,
              suffixIcon: SizedBox(
                height: 0.02.sh,
                child: GestureDetector(
                  onTap: () {
                    cubit.changeConfirmVisibility();
                  },
                  child: Icon(
                    cubit.isObscure1
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.grey73818D99,
                  ),
                ),
              ),
              obscureText: cubit.isObscure1,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }
}

class RegisterButtons extends StatelessWidget {
  const RegisterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onTap: () {},
          text: 'Create My Acount',
          fontColor: Colors.white,
          fontSize: 16,
          isGradient: true,
          borderColor: AppColors.transparent,
          borderRadius: 50,
        ),
        20.verticalSpace,
        CustomButton(
          onTap: () {
            context.pushNamed(Routes.login);
          },
          text: 'Already Have An account?',
          fontColor: AppColors.primary,
          fontSize: 16,
          borderColor: AppColors.primary,
          borderRadius: 50,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
