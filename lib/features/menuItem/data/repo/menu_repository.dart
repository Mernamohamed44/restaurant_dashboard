import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/categories/data/data_source/base_remote_categories_data_source.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/domin/repository/base_categories_repository.dart';
import 'package:restaurant_dashboard/features/menuItem/data/data_source/base_remote_menu_data_source.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/repository/base_menu_repository.dart';

class MenuRepository extends BaseMenuRepository {
  BaseRemoteMenuDataSource dataSource;
  MenuRepository(this.dataSource);

  @override
  Future<Either<ServerError, List<CategoriesItemEntity>>>
      getCategoriesItem(
  {
    required String items,
    required String id
}
      ) async {
    try {
      final result = await dataSource.getCategoriesItem(id: id,items: items);
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }
}
