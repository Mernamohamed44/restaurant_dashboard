import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_cached_image.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';

class ViewsCategories extends StatelessWidget {
  const ViewsCategories({super.key, required this.category, required this.views, required this.rank, this.isItem = false, required this.image});

  final String category;
  final String image;
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
              ? CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    child: CustomCachedImage(height: 50, fit: BoxFit.cover, image: '${ApiConstants.baseImagesUrl}/$image'),
                  ),
                )
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
                  percent: views * .01,
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
