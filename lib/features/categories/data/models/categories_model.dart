import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';

class CategoriesModel extends CategoriesEntity {
  CategoriesModel({
    required super.iV,
    required super.createdAt,
    required super.image,
    required super.itemsCount,
    required super.parent,
    required super.sId,
    required super.updatedAt,
    required super.user,
    required super.name,
    required super.views,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      iV: json["__v"],
      sId: json["_id"],
      createdAt: json["createdAt"],
      user: json["user"],
      name: json["name"],
      image: json["image"],
      parent: json["parent"]??'',
      views: json["views"],
      updatedAt: json["updatedAt"],
      itemsCount: json["itemsCount"],
    );
  }
}
