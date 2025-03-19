import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';

class ItemsModel extends ItemsEntities {
  ItemsModel(
      {required super.views,
      required super.sId,
      required super.user,
      required super.name,
      required super.image,
      required super.createdAt,
      required super.updatedAt,
      required super.iV,
      required super.category,
      required super.price,
      required super.description});

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      views: json["views"],
      sId: json["_id"],
      user: json["user"],
      name: json["name"],
      createdAt: json["createdAt"],
      image: json["image"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
      category: json["category"],
      price: json["price"],
      description: json["description"],
    );
  }
}
