import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_count_entity.dart';
import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_entities.dart';

abstract class BaseReviewsRepository {
  Future<Either<ServerError, List<ReviewsEntities>>> getReviews({
    required int page,
    required String ratingFilter,
    required String search,
  });
  Future<Either<ServerError, List<ReviewsCountEntities>>> countReviews();
}
