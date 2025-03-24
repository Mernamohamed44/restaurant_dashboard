import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/menuItem/data/models/categories_items_model.dart';

import 'base_remote_menu_data_source.dart';

class RemoteMenuDataSource extends BaseRemoteMenuDataSource {
  final dioManager = DioManager();

  @override
  Future<List<CategoriesItemModel>> getCategoriesItem(
      {required String items, required String id}) async {
    final Response response =
        await dioManager.get(ApiConstants.items, queryParameters: {
      items: id,
    });
    return List<CategoriesItemModel>.from(
        response.data.map((e) => CategoriesItemModel.fromJson(e)));
  }
}
