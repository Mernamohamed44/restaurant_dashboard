import 'package:get_it/get_it.dart';
import 'package:restaurant_dashboard/features/auth/auth/data/data_source/base_remote_auth_data_source.dart';
import 'package:restaurant_dashboard/features/auth/auth/data/data_source/remote_auth_data_source.dart';
import 'package:restaurant_dashboard/features/auth/auth/data/repo/auth_repository.dart';
import 'package:restaurant_dashboard/features/auth/auth/domain/repository/base_auth_repository.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/cubit/login_cubit.dart';
import 'package:restaurant_dashboard/features/auth/auth/presentation/cubit/register/register_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<BaseRemoteAuthDataSource>(
      () => RemoteAuthDataSource());
  getIt
      .registerLazySingleton<BaseAuthRepository>(() => AuthRepository(getIt()));
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
}
