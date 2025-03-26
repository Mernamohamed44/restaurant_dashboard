import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';

abstract class BaseMenuRepository {
  Future<Either<ServerError, List<CategoriesItemEntity>>> getCategoriesItem(
      {required String items,required String id,required int page});
  Future<Either<ServerError, void>>  addItem({
    required String name,
    required String description,
    required String image,
    required String category,
    required String subCategory,
    required String price,
  });
  Future<Either<ServerError, String>> uploadImage({
    required Uint8List? fileBytes,
    required String? myImage,
  });

}
