import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
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

  @override
  Future<Either<ServerError, void>> createAboutUs(
      {required String name,
      required String title,
      required String description,
      required List tags}) async {
    try {
      final result = await dataSource.createAboutUs(
          name: name, title: title, description: description, tags: tags);
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
  Future<Either<ServerError, void>> createReviews(
      {required String user,
      required String starRatingEnabled,
      required String generalCommentEnabled,
      required String customerNameRequired,
      required String customerEmailRequired,
      required String thankYouMessage,
      required List<Map> customInputs}) async {
    try {
      final result = await dataSource.createReviews(
          user: user,
          starRatingEnabled: starRatingEnabled,
          generalCommentEnabled: generalCommentEnabled,
          customerEmailRequired: customerEmailRequired,
          customerNameRequired: customerNameRequired,
          thankYouMessage: thankYouMessage,
          customInputs: customInputs);
      return Right(result);
    } on DioException catch (fail) {
      return Left(ServerFailure.fromDiorError(fail));
    }
    // catch (error) {
    //   return Left(
    //     ServerFailure(error.toString()),
    //   );
    // }
  }
}
