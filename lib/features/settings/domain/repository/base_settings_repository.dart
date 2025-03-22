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
  Future<Either<ServerError, void>> createAboutUs({
    required String name,
    required String title,
    required String description,
    required List tags,});
  Future<Either<ServerError, void>> createReviews({
    required String user,
    required String starRatingEnabled,
    required String generalCommentEnabled,
    required String customerNameRequired,
    required String customerEmailRequired,
    required String thankYouMessage,
    required List<Map> customInputs,
  }
      );

}
