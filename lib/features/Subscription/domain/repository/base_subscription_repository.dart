import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/Subscription/domain/entities/plans_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';

abstract class BaseSubscriptionRepository {
  Future<Either<ServerError, List<PlansEntities>>> getPlans();

}
