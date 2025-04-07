import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_count_entity.dart';
import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_entities.dart';

class ReviewsContainer extends StatelessWidget {
  ReviewsContainer({super.key, required this.reviewsCount});
  final List<ReviewsCountEntities> reviewsCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.containerColor),
      child: Column(
        children: [
          ...List.generate(
              reviewsCount.length,
              (index) => ReviewsRow(
                    star: index + 1,
                    reviewsCount: reviewsCount[index],
                  ))
        ],
      ),
    );
  }
}

class ReviewsRow extends StatelessWidget {
  const ReviewsRow({super.key, required this.reviewsCount, required this.star});
  final ReviewsCountEntities reviewsCount;
  final int star;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: FittedBox(
              child: RatingBar.builder(
                initialRating: star.toDouble(),
                // minRating: 1,
                itemSize: 20,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
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
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 2,
            child: LinearPercentIndicator(
              barRadius: const Radius.circular(12),
              lineHeight: 7,
              percent: 0.6,
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.boldContainerColor,
              progressColor: AppColors.primary,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CustomText(
            text: '${reviewsCount.count}',
            color: AppColors.textColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          const SizedBox(
            width: 3,
          ),
          CustomText(
            text: context.screenWidth > 400 ? 'Review' : '',
            color: AppColors.grey73818D99,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
