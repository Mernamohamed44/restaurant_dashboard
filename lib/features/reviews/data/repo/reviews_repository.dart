import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/base_remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';
import 'package:restaurant_dashboard/features/reviews/data/data_source/base_remote_reviews_data_source.dart';
import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_entities.dart';
import 'package:restaurant_dashboard/features/reviews/domain/repository/base_reviews_repository.dart';

class ReviewsRepository extends BaseReviewsRepository {
  final BaseRemoteReviewsDataSource dataSource;

  ReviewsRepository(this.dataSource);

  @override
  Future<Either<ServerError, List<ReviewsEntities>>> getReviews({
    required int page,
  }) async {
    try {
      final result = await dataSource.getReviews(
        page: page
      );
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    }
    catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }
}
