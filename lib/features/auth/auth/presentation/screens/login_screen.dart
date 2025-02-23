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

import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("screenWidth ${context.screenWidth}");

    return BlocProvider(
      create: (context) => getIt<LogInCubit>(),
      child: const LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: context.screenWidth >= 900 ? const LoginRow() : const LoginColumn(),
    );
  }
}

class LoginRow extends StatelessWidget {
  const LoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LogInCubit>();
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.screenHeight * .2,
                ),
                const CustomText(
                  text: 'Login',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
                const CustomText(
                  text: 'Welcome back dear.',
                  color: AppColors.grey73818D99,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                const Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                10.verticalSpace,
                const LoginTextField(),
                const Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                25.verticalSpace,
                const LoginButtons()
              ],
            ),
          ),
        ),
        Expanded(
          child: Image.asset(
            ImageManager.authWeb,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class LoginColumn extends StatelessWidget {
  const LoginColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LogInCubit>();

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
                const CustomText(
                  text: 'Login',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
                const CustomText(
                  text: 'Welcome back dear.',
                  color: AppColors.grey73818D99,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                const Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                10.verticalSpace,
                const LoginTextField(),
                const Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                25.verticalSpace,
                const LoginButtons(),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onTap: () {
            context.pushNamed(Routes.dashboard);
          },
          text: 'Login',
          fontColor: Colors.white,
          fontSize: 16,
          isGradient: true,
          borderColor: AppColors.transparent,
          borderRadius: 50,
        ),
        20.verticalSpace,
        CustomButton(
          onTap: () {
            context.pushNamed(Routes.register);
          },
          text: 'Don’t Have An account?',
          fontColor: AppColors.primary,
          fontSize: 16,
          borderColor: AppColors.primary,
          borderRadius: 50,
          fontWeight: FontWeight.w400,
        )
      ],
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LogInCubit>();

    return Column(
      children: [
        CustomTextFormField(
          title: 'Email Address or Phone Number',
          titleFontSize: 14,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter  Email Address or Phone Number';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        BlocBuilder<LogInCubit, LogInStates>(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<LogInCubit, LogInStates>(
              builder: (context, state) {
                return Row(
                  children: [
                    Checkbox(
                        checkColor: Colors.black,
                        fillColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(115, 129, 141, 0.05)),
                        activeColor: const Color.fromRGBO(115, 129, 141, 0.05),
                        side: const BorderSide(
                          color: Color.fromRGBO(115, 129, 141, 0.05),
                        ),
                        value: cubit.isChecked,
                        onChanged: (bool? value) {
                          cubit.changeChecked(value);
                        }),
                    const CustomText(
                      text: 'Keep me signed',
                      color: AppColors.grey73818D99,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ],
                );
              },
            ),
            10.horizontalSpace,
            const Flexible(
              child: FittedBox(
                child: CustomText(
                  text: 'Forget Your Password?',
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
