import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_entities.dart';
import 'package:restaurant_dashboard/features/reviews/presentation/cubit/reviews_cubit.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key, required this.reviews});
  final List<ReviewsEntities> reviews;
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    // Add a listener to the scroll controller

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ReviewsCubit>().refreshReviews();
      },
      child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewsDataLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          } else if (state is ReviewsDataFailedState) {
            return Center(
              child: CustomText(
                text: state.message,
                color: Colors.red,
                fontSize: 16,
              ),
            );
          } else {
            scrollController.addListener(() {
              if (scrollController.position.pixels >=
                  scrollController.position.maxScrollExtent - 200) {
                context.read<ReviewsCubit>().currentPage++;
                // Trigger load more when near the bottom
                context.read<ReviewsCubit>().getReviews(loadMore: true);
              }
            });

            return LayoutBuilder(builder: (context, constraints) {
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

              return Stack(
                alignment: Alignment.center,
                children: [
                  reviews.isEmpty
                      ? const Center(
                          child: CustomText(
                            text: 'No Reviews Yet',
                            color: AppColors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : GridView.builder(
                          controller: scrollController,
                          itemCount: reviews.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                            mainAxisExtent: 190,
                          ),
                          itemBuilder: (context, index) {
                            return ReviewListContainer(
                              reviewsData: reviews[index].fields!,
                              reviews: reviews[index],
                            );
                          }),
                  state is LoadingMoreReviewsState
                      ? const Positioned(
                          bottom: 0,
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ))
                      : SizedBox()
                ],
              );
            });
          }
        },
      ),
    );
  }
}

class ReviewListContainer extends StatelessWidget {
  const ReviewListContainer(
      {super.key, required this.reviewsData, required this.reviews});
  final FieldsEntities reviewsData;
  final ReviewsEntities reviews;

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
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgIcon(
                        height: 22,
                        icon: ImageManager.reviewsIconUp,
                        color: Color.fromRGBO(115, 129, 141, 0.24))
                  ],
                ),
                CustomText(
                  text: reviews.comment,
                  maxLines: 2,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                const Row(
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
              RatingBarIndicator(
                rating: reviews.rating.toDouble(),
                itemBuilder: (context, index) => const Icon(
                  Icons.star_rounded,
                  color: AppColors.primary,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              Flexible(
                child: CustomText(
                  maxLines: 1,
                  text: reviewsData.email!,
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
