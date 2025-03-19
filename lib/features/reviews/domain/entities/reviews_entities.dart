
abstract class ReviewsEntities {
  final String sId;
  final String user;
  final String reviewSettings;
  final int rating;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final FieldsEntities? fields;

  ReviewsEntities(
      {required this.sId,
      required this.user,
      required this.rating,
      required this.reviewSettings,
      required this.comment,
      required this.createdAt,
      required this.updatedAt,
      required this.fields,
      });
}

abstract class FieldsEntities {
  final String? serviceFeedback;
  final String? visitTime;
  final String? branchName;
  final int? cleanRating;
  final String? email;
  final String? name;

  FieldsEntities(
      {required this.serviceFeedback,
      required this.visitTime,
      required this.branchName,
      required this.cleanRating,
      required this.email,
      required this.name});
}
