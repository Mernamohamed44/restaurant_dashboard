import 'dart:io';
import 'dart:typed_data';

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

  @override
  Future<Either<ServerError, List<CategoriesEntity>>> getCategoriesData(
      {required String parent}) async {
    try {
      final result = await dataSource.getCategoriesData(parent: parent);
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, List<CategoriesEntity>>> getCategoriesDataForMenu(
      {required String parent}) async {
    try {
      final result = await dataSource.getCategoriesDataForMenu(parent: parent);
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, void>> addCategory(
      { String ? parent,
      required String image,
      required String name}) async {
    try {
      final result = await dataSource.addCategory(
          parent: parent, name: name, image: image);
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerError, String>> uploadImage({
    required Uint8List? fileBytes,
    required String? myImage,
  }) async {
    try {
      final result =
          await dataSource.uploadImage(myImage: myImage!, fileBytes: fileBytes!);
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
}
