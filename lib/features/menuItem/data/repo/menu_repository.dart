import 'dart:io';
import 'dart:typed_data';

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
  Future<Either<ServerError, List<CategoriesItemEntity>>> getCategoriesItem({
    required String items,
    required String id,
    required int page,
  }) async {
    try {
      final result = await dataSource.getCategoriesItem(
        id: id,
        items: items,
        page: page,
      );
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
  Future<Either<ServerError, void>> addItem(
      {required String name,
      required String description,
      required String image,
      required String category,
      required String subCategory,
      required String price}) async {
    try {
      final result = await dataSource.addItem(
          name: name,
          description: description,
          image: image,
          category: category,
          subCategory: subCategory,
          price: price);
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
