import 'package:restaurant_dashboard/features/reviews/domain/entities/reviews_entities.dart';

class ReviewsModel extends ReviewsEntities {
  ReviewsModel({
    required super.sId,
    required super.fields,
    required super.user,
    required super.reviewSettings,
    required super.comment,
    required super.createdAt,
    required super.updatedAt,
    required super.rating,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      sId: json["_id"],
      user: json["user"],
      reviewSettings: json["reviewSettings"],
      createdAt: json["createdAt"],
      comment: json["comment"],
      updatedAt: json["updatedAt"],
      rating: json["rating"],
      fields: FieldsModel.fromJson(json["fields"]),
    );
  }
}

class FieldsModel extends FieldsEntities {
  FieldsModel(
      {required super.serviceFeedback,
      required super.visitTime,
      required super.branchName,
      required super.cleanRating,
      required super.email,
      required super.name});
  factory FieldsModel.fromJson(Map<String, dynamic> json) {
    return FieldsModel(
      serviceFeedback: json['serviceFeedback'],
      visitTime: json['visitTime'],
      branchName: json['branchName'],
      cleanRating: json['cleanRating'],
      email: json['email'],
      name: json['name'],
    );
  }
}
