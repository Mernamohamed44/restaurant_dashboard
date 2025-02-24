import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/helper/color_extention.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';

import '../../../../app/utils/colors.dart';

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(19, 19, 19, 0.05)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: 'Close Side Bar',
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        SvgIcon(
                          icon: ImageManager.close,
                          color: AppColors.black,
                          height: 15,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 1, // Thickness of the line
                    color: const Color.fromRGBO(115, 129, 141, 0.16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: context
                                .read<SettingsCubit>()
                                .primaryController
                                .text
                                .toColor(),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Row(
                          children: [
                            SvgIcon(
                              icon: ImageManager.menu,
                              color: Color.fromRGBO(19, 19, 19, 0.32),
                              height: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: 'Our Menu',
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgIcon(
                              icon: ImageManager.warning,
                              color: Color.fromRGBO(19, 19, 19, 0.32),
                              height: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: CustomText(
                                text: 'About Us',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SvgIcon(
                              icon: ImageManager.headphone,
                              color: Color.fromRGBO(19, 19, 19, 0.32),
                              height: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: CustomText(
                                text: 'contact Us',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgIcon(
                              icon: ImageManager.reviews,
                              color: Color.fromRGBO(19, 19, 19, 0.32),
                              height: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: CustomText(
                                text: 'Review Service',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Container(
                  color: const Color.fromRGBO(247, 247, 247, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 210,
                        color: const Color.fromRGBO(247, 247, 247, 1),
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              color: AppColors.black,
                              child: Center(
                                child: Image.asset(ImageManager.logo),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 200,
                                  child: CustomTextFormField(
                                    borderColor:
                                        AppColors.white.withOpacity(.09),
                                    hintText: 'Search',
                                    hintFontSize: 14,
                                    filledColor:
                                        AppColors.white.withOpacity(.09),
                                    prefixIcon: SizedBox(
                                      height: 0.02.sh,
                                      child: GestureDetector(
                                          onTap: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SvgIcon(
                                              icon: ImageManager.search,
                                              color: Color.fromRGBO(
                                                  247, 247, 247, 1),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient:
                                                const LinearGradient(colors: [
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: context
                                              .read<SettingsCubit>()
                                              .primaryController
                                              .text
                                              .toColor(),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                        height: 15,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
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
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
