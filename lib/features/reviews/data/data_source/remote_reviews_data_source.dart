import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/items_model.dart';
import 'package:restaurant_dashboard/features/reviews/data/data_source/base_remote_reviews_data_source.dart';
import 'package:restaurant_dashboard/features/reviews/data/model/review_model.dart';

class RemoteReviewsDataSource extends BaseRemoteReviewsDataSource {
  final dioManager = DioManager();

  @override
  Future<List<ReviewsModel>> getReviews({
    required int page,
  }) async {
    final Response response = await dioManager.get(
      queryParameters: {
        'page': page,
        'limit':'5'
      },
      ApiConstants.allReviews,
    );
    return List<ReviewsModel>.from(
        response.data.map((e) => ReviewsModel.fromJson(e)));
  }
}
