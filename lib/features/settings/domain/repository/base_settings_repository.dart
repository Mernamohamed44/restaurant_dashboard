import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';

abstract class BaseSettingsRepository {
  Future<Either<ServerError, void>> createContacts({
    required List phones,
    required List emails,
    required List addresses,
    required List<Map> socialMedia,});

}
