import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/categories/data/models/categories_model.dart';

import 'base_remote_categories_data_source.dart';

class RemoteCategoriesDataSource extends BaseRemoteCategoriesDataSource {
  final dioManager = DioManager();

  @override
  Future<List<CategoriesModel>> superCategoriesData() async {
    final Response response =
        await dioManager.get(ApiConstants.categories, queryParameters: {
      'super': 'true',
      'itemsCount': 'true',
    });
    return List<CategoriesModel>.from(
        response.data.map((e) => CategoriesModel.fromJson(e)));
  }

  @override
  Future<List<CategoriesModel>> getCategoriesData(
      {required String parent}) async {
    final Response response =
        await dioManager.get(ApiConstants.categories, queryParameters: {
      'parent': parent,
    });
    return List<CategoriesModel>.from(
        response.data.map((e) => CategoriesModel.fromJson(e)));
  }

  @override
  Future<List<CategoriesModel>> getCategoriesDataForMenu(
      {required String parent}) async {
    final Response response = await dioManager.get(ApiConstants.categories,
        queryParameters: {'parent': parent, 'page': 1, 'limit': 100});
    return List<CategoriesModel>.from(
        response.data.map((e) => CategoriesModel.fromJson(e)));
  }

  @override
  addCategory(
      {String? parent, required String image, required String name}) async {
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
          "image": fileBytes != null
              ? MultipartFile.fromBytes(fileBytes,
                  filename: myImage, contentType: MediaType('image', 'jpeg'))
              : null,
        }));
    return response.data['image'];
  }
}
