import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/base_remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/repository/base_dashboard_repository.dart';
import 'package:restaurant_dashboard/features/settings/data/data_source/base_remote_settings_data_source.dart';
import 'package:restaurant_dashboard/features/settings/domain/repository/base_settings_repository.dart';

class SettingsRepository extends BaseSettingsRepository {
  final BaseRemoteSettingsDataSource dataSource;

  SettingsRepository(this.dataSource);

  @override
  Future<Either<ServerError, void>> createContacts(
      {required List phones,
      required List emails,
      required List addresses,
      required List<Map> socialMedia}) async {
    try {
      final result = await dataSource.createContacts(
          phones: phones,
          emails: emails,
          addresses: addresses,
          socialMedia: socialMedia);
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
