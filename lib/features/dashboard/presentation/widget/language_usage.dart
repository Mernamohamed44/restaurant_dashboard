import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';

class LanguagesUsage extends StatelessWidget {
  const LanguagesUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.boldContainerColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                      borderRadius:
                          BorderRadius.circular(12), // Clip it cleanly.

                      child: Image.asset(ImageManager.item, fit: BoxFit.cover)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.center,
                        child: CustomButton(
                          height: 40,
                          width: 40,
                          borderColor: AppColors.transparent,
                          isGradient: true,
                          widget: Center(
                            child: Image.asset(ImageManager.eye,
                                fit: BoxFit.cover),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Language Usage',
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        color: AppColors.primary,
                        size: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: FittedBox(
                          child: CustomText(
                            text: 'ar-iq',
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.circle_rounded,
                        color: AppColors.palePrimary,
                        size: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: FittedBox(
                          child: CustomText(
                            text: 'English',
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        color: AppColors.grey73818D,
                        size: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: FittedBox(
                          child: CustomText(
                            text: 'ar-eg',
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
