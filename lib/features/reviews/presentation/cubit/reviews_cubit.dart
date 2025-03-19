import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_entities.dart';
import 'package:restaurant_dashboard/features/reviews/domain/repository/base_reviews_repository.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this.repo) : super(ReviewsInitial());
  final BaseReviewsRepository repo;

  List<ReviewsEntities> reviews = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  Future getReviews({
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isLoadingMore || !hasMore) return; // Prevent multiple fetches
      isLoadingMore = true;
      emit(LoadingMoreReviewsState());
    } else {
      emit(ReviewsDataLoadingState());
    }
    final response = await repo.getReviews(page: currentPage);
    response.fold(
      (l) {
        emit(ReviewsDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
      reviews.addAll(r);
        emit(ReviewsDataSuccessState());
      },
    );
  }
  void refreshReviews() {
    currentPage = 1;
    isLoadingMore = false;
    hasMore = true;
    reviews.clear();
    getReviews();
  }
}
