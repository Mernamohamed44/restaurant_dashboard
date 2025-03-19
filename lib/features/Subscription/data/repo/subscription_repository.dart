import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/Subscription/data/data_source/base_remote_subscription_data_source.dart';
import 'package:restaurant_dashboard/features/Subscription/domain/entities/plans_entities.dart';
import 'package:restaurant_dashboard/features/Subscription/domain/repository/base_subscription_repository.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/base_remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/repository/base_dashboard_repository.dart';

class SubscriptionRepository extends BaseSubscriptionRepository {
  final BaseRemoteSubscriptionDataSource dataSource;

  SubscriptionRepository(this.dataSource);

  @override
  Future<Either<ServerError, List<PlansEntities>>> getPlans() async {
    try {
      final result = await dataSource.getPlans();
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
