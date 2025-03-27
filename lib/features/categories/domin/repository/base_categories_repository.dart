import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';

abstract class BaseCategoriesRepository {
  Future<Either<ServerError, List<CategoriesEntity>>> getSuperCategoriesData();
  Future<Either<ServerError, List<CategoriesChildrenEntity>>> getItemsSuperCategoriesData();
  Future<Either<ServerError, List<CategoriesEntity>>> getCategoriesData({required String parent});
  Future<Either<ServerError, List<CategoriesEntity>>> getCategoriesDataForMenu({required String parent});
  Future<Either<ServerError, void>>addCategory({ String? parent,required String image,required String name,});
  Future<Either<ServerError, String>> uploadImage({
     required Uint8List? fileBytes,
    required String? myImage,
  });

}