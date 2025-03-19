import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';

class CategoriesModel extends CategoriesEntities {
  CategoriesModel({
    required super.views,
    required super.sId,
    required super.user,
    required super.name,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
    required super.iV,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      views: json["views"],
      sId: json["_id"],
      user: json["user"],
      name: json["name"],
      createdAt: json["createdAt"],
      image: json["image"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
    );
  }
}
