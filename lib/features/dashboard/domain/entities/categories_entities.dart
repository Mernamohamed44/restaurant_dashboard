import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';

abstract class CategoriesEntities {
  final double views;
  final String sId;
  final String user;
  final String name;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int iV;
  CategoriesEntities(
      {required this.views,
      required this.sId,
      required this.user,
      required this.name,
      required this.image,
      required this.createdAt,
      required this.updatedAt,
      required this.iV});
  CategoriesModel copyWith({
    double? views,
    String? user,
    String? name,
    String? sId,
    String? updatedAt,
    String? image,
    String? createdAt,
    int? iV,
  }) {
    return CategoriesModel(
        views: views ?? this.views,
        user: user ?? this.user,
        name: name ?? this.name,
        sId: sId ?? this.sId,
        updatedAt: updatedAt ?? this.updatedAt,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        iV: iV ?? this.iV);
  }
}
