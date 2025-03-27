class CategoriesEntity {
  final String parent;
  final int? views;
  final String? sId;
  final String? name;
  final  String? image;
  final String? user;
  final String? createdAt;
  final  String? updatedAt;
  final int? iV;
  final  int? itemsCount;

  CategoriesEntity({
    required this.parent,
    required this.views,
    required this.sId,
    required this.name,
    required this.image,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
    required this.itemsCount,
  });
}

class CategoriesChildrenEntity {
  final String parent;
  final int? views;
  final String? sId;
  final String? name;
  final String? image;
  final String? user;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;
  final List <CategoriesEntity> children;

  CategoriesChildrenEntity({
    required this.parent,
    required this.views,
    required this.sId,
    required this.name,
    required this.image,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
    required this.children,
  });
}
