import 'dart:io';
import 'dart:typed_data';

import 'package:restaurant_dashboard/features/categories/data/models/categories_model.dart';
import 'package:restaurant_dashboard/features/menuItem/data/models/categories_items_model.dart';

abstract class BaseRemoteMenuDataSource {
  Future<List<CategoriesItemModel>> getCategoriesItem({
    required String items,
    required String id,
    required int page,
    required String search,
  });
  addItem({
    required String name,
    required String description,
    required String image,
    required String category,
    required String subCategory,
    required String price,
  });
  editItem({
    required String name,
    required String description,
    required String image,
    required String subCategory,
    required String id,
    required String price,
  });
  Future<String> uploadImage({
    required Uint8List fileBytes,
    required String myImage,
  });
  Future<void> deleteItems({required String id});
}
