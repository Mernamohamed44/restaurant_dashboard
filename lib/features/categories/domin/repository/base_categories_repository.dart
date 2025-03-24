import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';

abstract class BaseCategoriesRepository {
  Future<Either<ServerError, List<CategoriesEntity>>> getSuperCategoriesData();

}