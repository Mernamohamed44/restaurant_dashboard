import 'dart:io';
import 'dart:typed_data';

import 'package:restaurant_dashboard/features/categories/data/models/categories_model.dart';

abstract class BaseRemoteCategoriesDataSource {
  Future<List<CategoriesModel>> superCategoriesData();
  Future<List<CategoriesModel>> getCategoriesData({required String parent});
  Future<List<CategoriesModel>> getCategoriesDataForMenu({required String parent});
  Future<void> addCategory({ String? parent,required String image,required String name,});
  Future<String> uploadImage({
    required Uint8List fileBytes,
    required String myImage,
  });
}
