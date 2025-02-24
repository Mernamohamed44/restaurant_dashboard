import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        int crossAxisCount;
        if (context.screenWidth >= 1400) {
          crossAxisCount = 4;
        } else if (context.screenWidth >= 1200) {
          crossAxisCount = 3;
        } else if (context.screenWidth >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }
        return GridView.builder(
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              mainAxisExtent: 190,
            ),
            itemBuilder: (context, index) {
              return const ReviewListContainer();
            });
      }),
    );
  }
}

class ReviewListContainer extends StatelessWidget {
  const ReviewListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.containerColor),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgIcon(
                        height: 22,
                        icon: ImageManager.reviewsIconUp,
                        color: Color.fromRGBO(115, 129, 141, 0.24))
                  ],
                ),
                CustomText(
                  text:
                      'Mixed Rocca, Caesar, Fattoush, Armenian, Hummus with meat.',
                  maxLines: 2,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgIcon(
                        height: 22,
                        icon: ImageManager.reviewsIconDown,
                        color: Color.fromRGBO(115, 129, 141, 0.24))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBar.builder(
                initialRating: 3,
                // minRating: 1,
                itemSize: 20,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: AppColors.primary,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const Flexible(
                child: CustomText(
                  maxLines: 1,
                  text: 'islamsayedr@gmail.com',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
