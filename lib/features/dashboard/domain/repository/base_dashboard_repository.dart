import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';

abstract class BaseDashboardRepository {
  Future<Either<ServerError, List<CategoriesEntities>>> getCategoriesData();
}
