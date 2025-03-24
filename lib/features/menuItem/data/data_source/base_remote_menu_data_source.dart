import 'package:restaurant_dashboard/features/categories/data/models/categories_model.dart';
import 'package:restaurant_dashboard/features/menuItem/data/models/categories_items_model.dart';

abstract class BaseRemoteMenuDataSource {
  Future<List<CategoriesItemModel>> getCategoriesItem({required String items,required String id});
}
