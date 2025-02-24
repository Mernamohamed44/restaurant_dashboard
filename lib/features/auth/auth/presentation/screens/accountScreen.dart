import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/phone_number_input.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/cubit/account_cubit.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(),
      child: const AccountBody(),
    );
  }
}

class AccountBody extends StatelessWidget {
  const AccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
        key: adminScaffoldKey,
        sideBar: sideBar.sideBarMenus(context, Routes.account),
        body: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            leadingWidth: 30,
            leading: context.screenWidth < 377
                ? Center(
                    child: InkWell(
                      onTap: () {
                        adminScaffoldKey.currentState!.toggleSidebar();
                      },
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: const SvgIcon(
                        height: 20,
                        color: AppColors.textColor,
                        icon: ImageManager.drawerIcon,
                      ),
                    ),
                  )
                : const SizedBox(),
            titleSpacing: 5,
            title: const CustomText(
              text: 'Account',
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: CustomButton(
                  height: 20,
                  onTap: () {},
                  width: 150,
                  borderRadius: 25,
                  borderColor: AppColors.white,
                  color: const Color(0xffC04027),
                  widget: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        icon: ImageManager.logOut,
                        color: AppColors.white,
                        height: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: 'Log out',
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: const Color.fromRGBO(115, 129, 141, 0.16),
                height: 1,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: context.screenWidth > 600
                ? const AccountWeb()
                : const AccountMobile(),
          ),
        ));
  }
}

class AccountWeb extends StatelessWidget {
  const AccountWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                ImageManager.account,
                fit: BoxFit.cover,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140),
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 50,
                    child: Image.asset(
                      height: 35,
                      ImageManager.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100, left: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  title: ' Email Address',
                  titleFontSize: 14,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Email Address or Phone Number ';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    final cubit = context.read<AccountCubit>();
                    return PhoneNumberInput(
                      title: 'Phone Number',
                      onInputChanged: (PhoneNumber number) {
                        cubit.onInputChanged(number);
                      },
                    );
                  },
                ),
                10.verticalSpace,
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    final cubit = context.read<AccountCubit>();
                    return CustomTextFormField(
                      maxLines: 1,
                      title: 'New Password',
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
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    final cubit = context.read<AccountCubit>();

                    return CustomTextFormField(
                      maxLines: 1,
                      title: 'Enter New Password Again',
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
                25.verticalSpace,
                CustomButton(
                  onTap: () {},
                  text: 'save',
                  fontColor: Colors.white,
                  fontSize: 16,
                  isGradient: true,
                  borderColor: AppColors.transparent,
                  borderRadius: 50,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AccountMobile extends StatelessWidget {
  const AccountMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              ImageManager.account,
              fit: BoxFit.cover,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 130, left: 10),
              child: Align(
                alignment: context.screenWidth > 500
                    ? Alignment.center
                    : Alignment.bottomLeft,
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  radius: 55,
                  child: Image.asset(
                    height: 35,
                    ImageManager.logo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                title: ' Email Address',
                titleFontSize: 14,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Email Address or Phone Number ';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final cubit = context.read<AccountCubit>();
                  return PhoneNumberInput(
                    title: 'Phone Number',
                    onInputChanged: (PhoneNumber number) {
                      cubit.onInputChanged(number);
                    },
                  );
                },
              ),
              10.verticalSpace,
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final cubit = context.read<AccountCubit>();
                  return CustomTextFormField(
                    maxLines: 1,
                    title: 'New Password',
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
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final cubit = context.read<AccountCubit>();

                  return CustomTextFormField(
                    maxLines: 1,
                    title: 'Enter New Password Again',
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
              25.verticalSpace,
              CustomButton(
                onTap: () {},
                text: 'save',
                fontColor: Colors.white,
                fontSize: 16,
                isGradient: true,
                borderColor: AppColors.transparent,
                borderRadius: 50,
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        )
      ],
    );
  }
}
