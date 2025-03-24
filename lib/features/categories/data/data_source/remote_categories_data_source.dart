import 'package:dio/dio.dart';
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
}
