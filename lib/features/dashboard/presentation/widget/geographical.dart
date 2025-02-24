import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';

class GeographicalAccess extends StatelessWidget {
  const GeographicalAccess({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.boldContainerColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: text,
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                      borderRadius:
                          BorderRadius.circular(12), // Clip it cleanly.

                      child: Image.asset(ImageManager.geographical,
                          fit: BoxFit.cover)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        alignment: Alignment.center,
                        child: CustomButton(
                          width: 200,
                          borderRadius: 25,
                          borderColor: AppColors.transparent,
                          isGradient: true,
                          widget: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ImageManager.eye,
                                    fit: BoxFit.cover),
                                const Flexible(
                                    child: FittedBox(
                                        child: CustomText(
                                            text: 'Upgrade To View',
                                            color: Colors.white)))
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
