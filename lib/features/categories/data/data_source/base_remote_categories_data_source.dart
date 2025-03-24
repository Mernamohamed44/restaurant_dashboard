import 'package:restaurant_dashboard/features/categories/data/models/categories_model.dart';

abstract class BaseRemoteCategoriesDataSource {
  Future<List<CategoriesModel>> superCategoriesData();
}
