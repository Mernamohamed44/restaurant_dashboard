import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';

class ViewsCategories extends StatelessWidget {
  const ViewsCategories(
      {super.key,
      required this.category,
      required this.views,
      required this.rank,
      this.isItem = false});

  final String category;

  final double views;
  final int rank;
  final bool isItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          isItem
              ? Image.asset(ImageManager.item)
              : Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.boldContainerColor,
                  ),
                  child: CustomText(
                    text: ' # \t $rank',
                    color: AppColors.textColor,
                  )),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: category,
                  color: AppColors.accentContainerColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(12),
                  lineHeight: 7,
                  percent: views*.1,
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColors.boldContainerColor,
                  progressColor: AppColors.primary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
