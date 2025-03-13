import 'package:get_it/get_it.dart';
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
}
