import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';

abstract class BaseMenuRepository {
  Future<Either<ServerError, List<CategoriesItemEntity>>> getCategoriesItem(
      {required String items,required String id});
}
