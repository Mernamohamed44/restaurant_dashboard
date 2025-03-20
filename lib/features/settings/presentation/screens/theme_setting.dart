import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

class ThemeSettingScreen extends StatelessWidget {
  const ThemeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingsCubit>(),
      child: const ThemeSettingBody(),
    );
  }
}

class ThemeSettingBody extends StatelessWidget {
  const ThemeSettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
        key: adminScaffoldKey,
        sideBar: sideBar.sideBarMenus(context, Routes.themeSetting),
        body: Scaffold(
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
              text: 'Theme Settings',
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: const Color.fromRGBO(115, 129, 141, 0.16),
                height: 1,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                context.screenWidth < 800
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.red.withOpacity(.05),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImageManager.warning,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Flexible(
                                      child: CustomText(
                                        maxLines: 3,
                                        text:
                                            'Please note that Realtime preview only available in large screens',
                                        color: Color(0xffC04027),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(0xffC04027),
                                  child: Icon(
                                    Icons.clear,
                                    color: AppColors.white,
                                    size: 10,
                                  ))
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CustomText(
                                  text: 'Choose Theme',
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  height: 1, // Thickness of the line
                                  color:
                                      const Color.fromRGBO(115, 129, 141, 0.16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.palePrimary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImageManager.simpleTheme,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const CustomText(
                                              text: 'Simple Theme',
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                            const SizedBox(
                                              width: 70,
                                            ),
                                            CustomText(
                                              text: 'Current',
                                              color: AppColors.white
                                                  .withOpacity(.5),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  DottedBorder(
                                    color: AppColors.primary,
                                    strokeWidth: 1,
                                    radius: const Radius.circular(20),
                                    borderType: BorderType.RRect,
                                    child: Container(
                                      padding: const EdgeInsets.all(45),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.primary
                                              .withOpacity(.05)),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SvgIcon(
                                              icon: ImageManager.store,
                                              color: AppColors.primary,
                                              height: 35,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              maxLines: 4,
                                              text: TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'Go to the ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors
                                                          .accentContainerColor, // Normal text color
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'store',
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            print("Clicked!");
                                                          },
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // Make it bold
                                                      color: AppColors.primary,
                                                      // Make it look like a link
                                                      decoration: TextDecoration
                                                          .underline, // Optional: underline effect
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: ' to get more themes',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors
                                                          .accentContainerColor, // Normal text color
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const CustomText(
                                  text: 'Customize Current Theme',
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  height: 1, // Thickness of the line
                                  color:
                                      const Color.fromRGBO(115, 129, 141, 0.16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                final cubit = context.read<SettingsCubit>();
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: AppColors.containerColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: .7,
                                        child: Switch(
                                            activeColor: AppColors.primary,
                                            value: cubit.starRatingValue,
                                            onChanged: (value) {
                                              cubit
                                                  .changeStarRatingValue(value);
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Flexible(
                                        child: CustomText(
                                            text: 'Super Categories',
                                            color: AppColors.textColor),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                final cubit = context.read<SettingsCubit>();
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: AppColors.containerColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: .7,
                                        child: Switch(
                                            activeColor: AppColors.primary,
                                            value: cubit.starRatingValue,
                                            onChanged: (value) {
                                              cubit
                                                  .changeStarRatingValue(value);
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Flexible(
                                        child: CustomText(
                                            text: 'Show Category Image',
                                            color: AppColors.textColor),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                final cubit = context.read<SettingsCubit>();
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: AppColors.containerColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: .7,
                                        child: Switch(
                                            activeColor: AppColors.primary,
                                            value: cubit.starRatingValue,
                                            onChanged: (value) {
                                              cubit
                                                  .changeStarRatingValue(value);
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Flexible(
                                        child: CustomText(
                                            text: 'Use Hero Image',
                                            color: AppColors.textColor),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const AddImageContainer(),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                final cubit = context.read<SettingsCubit>();
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: .7,
                                        child: Switch(
                                            activeColor: AppColors.primary,
                                            value: cubit.starRatingValue,
                                            onChanged: (value) {
                                              cubit
                                                  .changeStarRatingValue(value);
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Flexible(
                                        child: CustomText(
                                            text: 'Add Custom CSS Classes',
                                            color: AppColors.textColor),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              maxLines: 4,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text:
                                        'This Feature is Available for pro users only Please',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors
                                          .accentContainerColor, // Normal text color
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Upgrade',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Clicked!");
                                      },
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // Make it bold
                                      color: AppColors.primary,
                                      // Make it look like a link
                                      decoration: TextDecoration
                                          .underline, // Optional: underline effect
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'To Pro to use It.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors
                                          .accentContainerColor, // Normal text color
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomTextFormField(
                              maxLines: 10,
                              hintText:
                                  '/* Place  your CSS code here and press save */',
                              // suffixIcon: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     CustomButton(
                              //       onTap: (){},
                              //       text: 'Save',
                              //       fontSize: 14,
                              //       color: AppColors.grey,
                              //     ),
                              //   ],
                              // ),
                            )
                          ],
                        ),
                      ),
                    ),
                    context.screenWidth > 800
                        ? Expanded(
                            flex: 2,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                color: AppColors.boldContainerColor,
                                child: const Preview()))
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class AddImageContainer extends StatelessWidget {
  const AddImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary.withOpacity(.05),
          border: Border.all(color: AppColors.primary)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageManager.addImage),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Category Image',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                RichText(
                  maxLines: 6,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Click here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<SettingsCubit>().chooseImage(
                                source: ImageSource.gallery, context: context);
                            print("Clicked!");
                          },
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          // Make it bold
                          color: AppColors.primary,
                          // Make it look like a link
                          decoration: TextDecoration
                              .underline, // Optional: underline effect
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' to upload an image, min height 100px, these extensions are acceptable .svg, .png, .jpeg',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors
                              .accentContainerColor, // Normal text color
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Preview',
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromRGBO(115, 129, 141, 0.05),
                  child: SvgIcon(
                    icon: ImageManager.mobile,
                    color: AppColors.textColor,
                    height: 15,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromRGBO(115, 129, 141, 0.05),
                  child: SvgIcon(
                    icon: ImageManager.tablet,
                    color: AppColors.textColor,
                    height: 15,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.palePrimary,
                  child: SvgIcon(
                    icon: ImageManager.web,
                    color: AppColors.white,
                    height: 15,
                  ),
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 210,
              //color: const Color.fromRGBO(247, 247, 247, 1),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: AppColors.black,
                    child: Image.asset(ImageManager.logo),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 17),
                          child: SvgIcon(
                            icon: ImageManager.close,
                            color: AppColors.white,
                            height: 20,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: CustomTextFormField(
                            borderColor: AppColors.white.withOpacity(.09),
                            hintText: 'Search',
                            hintFontSize: 14,
                            filledColor: AppColors.white.withOpacity(.09),
                            prefixIcon: SizedBox(
                              height: 0.02.sh,
                              child: GestureDetector(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SvgIcon(
                                      icon: ImageManager.search,
                                      color: Color.fromRGBO(247, 247, 247, 1),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xff3D7562),
                                    Color(0xffE8B74C),
                                  ])),
                              child: const Row(
                                children: [
                                  CustomText(
                                    text: 'Food Menu',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.white),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Color(0xffD9D9D9),
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  CustomText(
                                    text: 'Soup',
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffFFC600),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Color(0xffD9D9D9),
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  CustomText(
                                    text: 'salad',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.white),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Color(0xffD9D9D9),
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  CustomText(
                                    text: 'Cold Appetizers',
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 45,
                                  child: Image.asset(ImageManager.salad)),
                              const CustomText(
                                text: 'Salad',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              const CustomText(
                                text: '20,000',
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 45,
                                  child: Image.asset(ImageManager.salad)),
                              const CustomText(
                                text: 'Salad',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              const CustomText(
                                text: '20,000',
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 45,
                                  child: Image.asset(ImageManager.salad)),
                              const CustomText(
                                text: 'Salad',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              const CustomText(
                                text: '20,000',
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 45,
                                  child: Image.asset(ImageManager.salad)),
                              const CustomText(
                                text: 'Salad',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              const CustomText(
                                text: '20,000',
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
