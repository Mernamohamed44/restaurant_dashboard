import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/items_model.dart';

abstract class BaseRemoteDashboardDataSource {
  Future<List<CategoriesModel>> getCategoriesData();
  Future<List<ItemsModel>> getItemsData();
  Future<int> reviewsCount();
}
