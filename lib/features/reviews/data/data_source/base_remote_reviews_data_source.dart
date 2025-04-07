import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/items_model.dart';
import 'package:restaurant_dashboard/features/reviews/data/model/review_model.dart';
import 'package:restaurant_dashboard/features/reviews/data/model/reviews_count_model.dart';

abstract class BaseRemoteReviewsDataSource {
  Future<List<ReviewsModel>> getReviews({required int page,required String ratingFilter,required String search});
  Future<List<ReviewsCountModel>> countReviews();
}
