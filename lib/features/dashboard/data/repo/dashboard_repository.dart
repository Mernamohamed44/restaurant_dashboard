import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/base_remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/repository/base_dashboard_repository.dart';

class DashboardRepository extends BaseDashboardRepository {
  final BaseRemoteDashboardDataSource dataSource;

  DashboardRepository(this.dataSource);

  @override
  Future<Either<ServerError, List<CategoriesEntities>>>
      getCategoriesData() async {
    try {
      final result = await dataSource.getCategoriesData();
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    }
    catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, List<ItemsEntities>>> getItemsData() async {
    try {
      final result = await dataSource.getItemsData();
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    }
    catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, int>> reviewsCount() async {
    try {
      final result = await dataSource.reviewsCount();
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
