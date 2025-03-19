import 'package:get_it/get_it.dart';
import 'package:restaurant_dashboard/features/Subscription/data/data_source/base_remote_subscription_data_source.dart';
import 'package:restaurant_dashboard/features/Subscription/data/data_source/remote_subscription_data_source.dart';
import 'package:restaurant_dashboard/features/Subscription/data/repo/subscription_repository.dart';
import 'package:restaurant_dashboard/features/Subscription/domain/repository/base_subscription_repository.dart';
import 'package:restaurant_dashboard/features/Subscription/presentation/cubit/subscription_cubit.dart';
import 'package:restaurant_dashboard/features/auth/auth/data/data_source/base_remote_auth_data_source.dart';
import 'package:restaurant_dashboard/features/auth/auth/data/data_source/remote_auth_data_source.dart';
import 'package:restaurant_dashboard/features/auth/auth/data/repo/auth_repository.dart';
import 'package:restaurant_dashboard/features/auth/auth/domain/repository/base_auth_repository.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/cubit/account_cubit.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/cubit/login_cubit.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/cubit/register_cubit.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/base_remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/data/data_source/remote_dashboard_data_source.dart';
import 'package:restaurant_dashboard/features/dashboard/data/repo/dashboard_repository.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/repository/base_dashboard_repository.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:restaurant_dashboard/features/reviews/data/data_source/base_remote_reviews_data_source.dart';
import 'package:restaurant_dashboard/features/reviews/data/data_source/remote_reviews_data_source.dart';
import 'package:restaurant_dashboard/features/reviews/data/repo/reviews_repository.dart';
import 'package:restaurant_dashboard/features/reviews/domain/repository/base_reviews_repository.dart';
import 'package:restaurant_dashboard/features/reviews/presentation/cubit/reviews_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<BaseRemoteAuthDataSource>(
      () => RemoteAuthDataSource());
  getIt
      .registerLazySingleton<BaseAuthRepository>(() => AuthRepository(getIt()));
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerFactory<AccountCubit>(() => AccountCubit(getIt()));
  getIt.registerLazySingleton<BaseRemoteDashboardDataSource>(
      () => RemoteDashboardDataSource());
  getIt.registerLazySingleton<BaseDashboardRepository>(
      () => DashboardRepository(getIt()));
  getIt.registerFactory<DashboardCubit>(() => DashboardCubit(getIt()));

  ///Reviews
  getIt.registerLazySingleton<BaseRemoteReviewsDataSource>(
      () => RemoteReviewsDataSource());
  getIt.registerLazySingleton<BaseReviewsRepository>(
      () => ReviewsRepository(getIt()));
  getIt.registerFactory<ReviewsCubit>(() => ReviewsCubit(getIt()));
  ///subscription
  getIt.registerLazySingleton<BaseRemoteSubscriptionDataSource>(
          () => RemoteSubscriptionDataSource());
  getIt.registerLazySingleton<BaseSubscriptionRepository>(
          () => SubscriptionRepository(getIt()));
  getIt.registerFactory<SubscriptionCubit>(() => SubscriptionCubit(getIt()));
}
