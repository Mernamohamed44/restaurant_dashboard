import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:restaurant_dashboard/app/caching/shared_prefs.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/categories/data/models/categories_model.dart';

import 'base_remote_categories_data_source.dart';

class RemoteCategoriesDataSource extends BaseRemoteCategoriesDataSource {
  final dioManager = DioManager();

  @override
  Future<List<CategoriesModel>> superCategoriesData() async {
    final Response response = await dioManager.get(ApiConstants.categories, queryParameters: {
      'super': 'true',
      'itemsCount': 'true',
    });
    return List<CategoriesModel>.from(response.data.map((e) => CategoriesModel.fromJson(e)));
  }

  @override
  Future<List<CategoriesModel>> getCategoriesData({required String parent}) async {
    final Response response = await dioManager.get(ApiConstants.categories, queryParameters: {
      'parent': parent,
    });
    return List<CategoriesModel>.from(response.data.map((e) => CategoriesModel.fromJson(e)));
  }

  @override
  Future<List<CategoriesModel>> getCategoriesDataForMenu({required String? parent}) async {
    final Response response = await dioManager.get(ApiConstants.categories, queryParameters: {
      if (parent != null) 'parent': parent,
      'page': 1,
      'limit': 100,
    });
    return List<CategoriesModel>.from(response.data.map((e) => CategoriesModel.fromJson(e)));
  }

  @override
  addCategory({String? parent, required String image, required String name}) async {
    await dioManager.post(
      ApiConstants.categories,
      data: {
        if (parent != null) 'parent': parent,
        'name': name,
        'image': image,
      },
    );
  }

  @override
  Future<String> uploadImage({
    required Uint8List? fileBytes,
    required String? myImage,
  }) async {
    final Response response = await dioManager.post(ApiConstants.uploadsImage,
        data: FormData.fromMap({
          "image": fileBytes != null ? MultipartFile.fromBytes(fileBytes, filename: myImage, contentType: MediaType('image', 'jpeg')) : null,
        }));
    return response.data['image'];
  }

  @override
  Future<List<CategoriesChildrenModel>> getItemsSuperCategoriesData() async {
    final Response response = await dioManager.get(ApiConstants.categories, queryParameters: {
      'children': 'true',
    });
    return List<CategoriesChildrenModel>.from(response.data.map((e) => CategoriesChildrenModel.fromJson(e)));
  }

  @override
  Future<void> editSuperCategoriesData({required String? parent, required String image, required String name, required String id}) async {
    await dioManager.put(
      '${ApiConstants.categories}/$id',
      data: {
        'user': Caching.get(key: 'user'),
        if (parent != null) 'parent': parent,
        'name': name,
        'image': image,
      },
    );
  }

  @override
  Future<void> deleteSuperCategoriesData({required String id}) async {
    await dioManager.delete(
      '${ApiConstants.categories}/$id',
    );
  }
}
