import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/auth/auth/domain/entities/user_data_entity.dart';

import '../../domain/entities/auth_entity.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../data_source/base_remote_auth_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseRemoteAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<Either<ServerError, AuthEntity>> login({
    required String userName,
    required String password,
  }) async {
    try {
      final result = await dataSource.login(
        userName: userName,
        password: password,
      );
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
  Future<Either<ServerError, AuthEntity>> register({
    required String displayName,
    required String username,
    required String password,
    required String phone,
  }) async {
    try {
      final result = await dataSource.register(
          displayName: displayName,
          username: username,
          password: password,
          phone: phone);
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
  Future<Either<ServerError, String?>> sendCode({
    required String phone,
  }) async {
    try {
      final result = await dataSource.sendCode(
        phone: phone,
      );
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
  Future<Either<ServerError, void>> reSendCode({
    required String phone,
  }) async {
    try {
      final result = await dataSource.reSendCode(
        phone: phone,
      );
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
  Future<Either<ServerError, bool>> checkUsername({
    required String username,
  }) async {
    try {
      final result = await dataSource.checkUsername(
        username: username,
      );
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
  Future<Either<ServerError, UserDataEntity>> getUserData() async {
    try {
      final result = await dataSource.getUserData();
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
  Future<Either<ServerError, void>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      final result = await dataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
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
