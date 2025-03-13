import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/base_remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';

class RemoteDashboardDataSource extends BaseRemoteDashboardDataSource {
  final dioManager = DioManager();

  @override
  Future<List<CategoriesModel>> getCategoriesData() async {
    final Response response = await dioManager
        .get(ApiConstants.categories, queryParameters: {'sort': '-views'});
    return List<CategoriesModel>.from(
        response.data.map((e) => CategoriesModel.fromJson(e)));

  }
}
