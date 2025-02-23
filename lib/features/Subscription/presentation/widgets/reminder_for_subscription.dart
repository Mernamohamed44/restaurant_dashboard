import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

class ReminderSubscription extends StatelessWidget {
  const ReminderSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(254, 145, 29, 1),
              Color.fromRGBO(9, 147, 167, 1)
            ],
          )),
      child: context.screenWidth > 500
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Row(
                    children: [
                      SvgIcon(
                        icon: ImageManager.alarm,
                        color: AppColors.white,
                        height: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: '3 Days left for the next bill',
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    child: CustomButton(
                      borderRadius: 25,
                      width: 300,
                      color: AppColors.white,
                      borderColor: AppColors.white,
                      isGradient: true,
                      widget: const Row(
                        children: [
                          SvgIcon(
                              icon: ImageManager.extend,
                              height: 20,
                              color: AppColors.primary),
                          SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            text: 'Extend your subscription for more time!',
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    SvgIcon(
                      icon: ImageManager.alarm,
                      color: AppColors.white,
                      height: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomText(
                      text: '3 Days left for the next bill',
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ],
                ),
                CustomButton(
                  borderRadius: 25,
                  width: 300,
                  color: AppColors.white,
                  borderColor: AppColors.white,
                  isGradient: true,
                  widget: const Row(
                    children: [
                      SvgIcon(
                          icon: ImageManager.extend,
                          height: 20,
                          color: AppColors.primary),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: CustomText(
                          text: 'Extend your subscription for more time!',
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
    );
  }
}
