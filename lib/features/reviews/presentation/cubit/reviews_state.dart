part of 'reviews_cubit.dart';

@immutable
abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}
class LoadingMoreReviewsState extends ReviewsState {}
class ReviewsDataLoadingState extends ReviewsState {}

class ReviewsDataSuccessState extends ReviewsState {}

class ReviewsDataFailedState extends ReviewsState {
  final String message;

  ReviewsDataFailedState({required this.message});
}

