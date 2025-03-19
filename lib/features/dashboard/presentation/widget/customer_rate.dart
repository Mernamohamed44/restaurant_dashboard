import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';

class CustomerRate extends StatelessWidget {
  const CustomerRate({super.key, required this.reviewsNumber});

  final int reviewsNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.palePrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Customer Overall Rate',
            color: AppColors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              FittedBox(
                child: RatingBar.builder(
                  initialRating: 3,
                  // minRating: 1,
                  itemSize: 15,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Colors.white,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              Flexible(
                child: CustomText(
                  text: '( $reviewsNumber review )',
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
