import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_count_entity.dart';

class ReviewsCountModel extends ReviewsCountEntities {
  ReviewsCountModel({
    required super.count,

    required super.rating,
  });

  factory ReviewsCountModel.fromJson(Map<String, dynamic> json) {
    return ReviewsCountModel(
      rating: json["rating"],
      count: json["count"],

    );
  }
}