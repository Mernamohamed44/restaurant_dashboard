import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/categories/data/data_source/base_remote_categories_data_source.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/domin/repository/base_categories_repository.dart';

class CategoriesRepository extends BaseCategoriesRepository {
  BaseRemoteCategoriesDataSource dataSource;
  CategoriesRepository(this.dataSource);

  @override
  Future<Either<ServerError, List<CategoriesEntity>>>
      getSuperCategoriesData() async {
    try {
      final result = await dataSource.superCategoriesData();
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
