import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';

abstract class BaseRemoteDashboardDataSource {
  Future<List<CategoriesModel>> getCategoriesData();
}
