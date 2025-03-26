import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/menuItem/data/models/categories_items_model.dart';

import 'base_remote_menu_data_source.dart';

class RemoteMenuDataSource extends BaseRemoteMenuDataSource {
  final dioManager = DioManager();

  @override
  Future<List<CategoriesItemModel>> getCategoriesItem({
    required String items,
    required String id,
    required int page,
  }) async {
    final Response response = await dioManager.get(ApiConstants.items,
        queryParameters: {items: id, 'page': page, 'limit': 20});
    return List<CategoriesItemModel>.from(
        response.data.map((e) => CategoriesItemModel.fromJson(e)));
  }

  @override
  addItem(
      {required String name,
      required String description,
      required String image,
      required String category,
      required String subCategory,
      required String price}) async {
    final Response response = await dioManager.post(ApiConstants.items, data: {
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'subCategory': subCategory,
      'price': price,
    });
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
