import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';

class CategoriesItemModel extends CategoriesItemEntity {
  CategoriesItemModel({
    required super.iV,
    required super.createdAt,
    required super.image,
    required super.category,
    required super.description,
    required super.sId,
    required super.price,
    required super.subCategory,
    required super.updatedAt,
    required super.user,
    required super.name,
    required super.views,
  });

  factory CategoriesItemModel.fromJson(Map<String, dynamic> json) {
    return CategoriesItemModel(
      iV: json["__v"],
      sId: json["_id"],
      createdAt: json["createdAt"],
      user: json["user"],
      name: json["name"],
      image: json["image"],
      category: json["category"],
      views: json["views"],
      updatedAt: json["updatedAt"],
      subCategory: json["subCategory"],
      price: json["price"],
      description: json["description"],
    );
  }
}
