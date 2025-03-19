import 'package:restaurant_dashboard/features/dashboard/data/model/items_model.dart';

abstract class ItemsEntities {
  final int views;
  final String sId;
  final String user;
  final String name;
  final String image;
  final String createdAt;
  final String description;
  final int price;
  final String category;
  final String updatedAt;
  final int iV;

  ItemsEntities(
      {required this.views,
      required this.sId,
      required this.user,
      required this.name,
      required this.image,
      required this.createdAt,
      required this.updatedAt,
      required this.description,
      required this.price,
      required this.category,
      required this.iV});

  ItemsModel copyWith({
    int? views,
    String? user,
    String? name,
    String? sId,
    String? updatedAt,
    String? image,
    String? createdAt,
    int? price,
    String? category,
    String? description,
    int? iV,
  }) {
    return ItemsModel(
      views: views ?? this.views,
      user: user ?? this.user,
      name: name ?? this.name,
      sId: sId ?? this.sId,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      iV: iV ?? this.iV,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }
}
