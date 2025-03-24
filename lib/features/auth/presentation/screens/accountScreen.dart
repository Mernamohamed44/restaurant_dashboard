import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:restaurant_dashboard/app/caching/shared_prefs.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
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
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/auth/presentation/cubit/account_cubit.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountCubit>()..getUserData(),
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
                  onTap: () {
                    Caching.clearAllData();
                    context.pushReplacementNamed(Routes.login);
                  },
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
          body: BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
              if (state is UserDataLoadingState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primary,
                ));
              }
              return SingleChildScrollView(
                child: context.screenWidth > 600
                    ? const AccountWeb()
                    : const AccountMobile(),
              );
            },
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
          const SizedBox(
            height: 240,
            child: ProfileImage(),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.25.sw),
            child: ProfileTextField(
              cubit: context.read<AccountCubit>(),
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
        const ProfileImage(),
        const SizedBox(
          height: 40,
        ),
        ProfileTextField(
          cubit: context.read<AccountCubit>(),
        )
      ],
    );
  }
}

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({super.key, required this.cubit});

  final AccountCubit cubit;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (widget.cubit.emailController.text.isNotEmpty) {
          debugPrint(widget.cubit.emailController.text);
          widget.cubit.checkUsername();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                title: 'Full Name',
                controller: context.read<AccountCubit>().nameController,
                titleFontSize: 14,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter  Full Name ';
                  }
                  return null;
                },
              ),
              10.verticalSpace,
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  return CustomTextFormField(
                    title: 'Email Address',
                    focusNode: _focusNode,
                    controller: context.read<AccountCubit>().emailController,
                    titleFontSize: 14,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid Email Address ';
                      } else if (value ==
                          context.read<AccountCubit>().user!.username) {
                        return null;
                      } else if (widget.cubit.isUsernameAvailable) {
                        return "Email Address is available!";
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final cubit = context.read<AccountCubit>();
                  return PhoneNumberInput(
                    controller: cubit.phoneController,
                    isoCode: cubit.isoCode,
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
                    title: 'Old Password',
                    controller: cubit.oldPasswordController,
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
                    title: 'New Password',
                    controller: cubit.newPasswordController,
                    titleFontSize: 14,
                    suffixIcon: SizedBox(
                      height: 0.02.sh,
                      child: GestureDetector(
                        onTap: () {
                          cubit.changeNewPasswordVisibility();
                        },
                        child: Icon(
                          cubit.isObscure2
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
                    controller: cubit.confirmPasswordController,
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
              BlocConsumer<AccountCubit, AccountState>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccessState) {
                    showToastificationWidget(
                      message: 'Password changed Successfully',
                      context: context,
                    );
                  } else if (state is ChangePasswordFailState) {
                    showToastificationWidget(
                      message: state.message,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<AccountCubit>();
                  if (state is ChangePasswordLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  return CustomButton(
                    onTap: () {
                      cubit.changePassword();
                    },
                    text: 'save',
                    fontColor: Colors.white,
                    fontSize: 16,
                    isGradient: true,
                    borderColor: AppColors.transparent,
                    borderRadius: 50,
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    image: ImageManager.logo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
