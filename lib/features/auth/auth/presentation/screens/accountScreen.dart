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
import 'package:restaurant_dashboard/app/widget/custom_cached_image.dart';
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
                  height: 40,
                  onTap: () {},
                  width: 110,
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
            child: context.screenWidth > 600 ? const AccountWeb() : const AccountMobile(),
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
          SizedBox(
            height: 240,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  ImageManager.account,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(40),
                          child: const CustomCachedImage(
                            image:
                                "https://s3-alpha-sig.figma.com/img/be72/a765/08472652a0debe5195a33455348efc14?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=V6szh0oYawpU5seosn3l3MNqxfSfCRbGPkQfKbD7kAxi5-j53BYPBVrhuSTVlnoeKnTgDlsw~PiIVoAoC3JHkUQaBAxPsfTr~vCEeNj31BJXseueZZB-JkZ1YTwC2k1BvYWL~ibC1vRHcWhBTzfHCQcN8EhsN0vOffAj-Jh6Gibc~xhaqGqp7Vzj4MDfY~mgNyDKhPLw6S9yOzRJD9ap0fbE-E0~iLQUakBrDwM6g8y8U~SVdnWj-NWgYecGo7PKUnIzgL3vMTwNiJbs4ku0RY4OlrijEsE0D0qOsZsRcCxYvfcO2ydB7RRdL9lDLGoMZIukRidr6IVHTQ0CN9S7Sw__",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.25.sw),
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
                            cubit.isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                            cubit.isObscure1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                alignment: context.screenWidth > 500 ? Alignment.center : Alignment.bottomLeft,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(40),
                        child: const CustomCachedImage(
                          image:
                          "https://s3-alpha-sig.figma.com/img/be72/a765/08472652a0debe5195a33455348efc14?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=V6szh0oYawpU5seosn3l3MNqxfSfCRbGPkQfKbD7kAxi5-j53BYPBVrhuSTVlnoeKnTgDlsw~PiIVoAoC3JHkUQaBAxPsfTr~vCEeNj31BJXseueZZB-JkZ1YTwC2k1BvYWL~ibC1vRHcWhBTzfHCQcN8EhsN0vOffAj-Jh6Gibc~xhaqGqp7Vzj4MDfY~mgNyDKhPLw6S9yOzRJD9ap0fbE-E0~iLQUakBrDwM6g8y8U~SVdnWj-NWgYecGo7PKUnIzgL3vMTwNiJbs4ku0RY4OlrijEsE0D0qOsZsRcCxYvfcO2ydB7RRdL9lDLGoMZIukRidr6IVHTQ0CN9S7Sw__",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                          cubit.isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                          cubit.isObscure1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
