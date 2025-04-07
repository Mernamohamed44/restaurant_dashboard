import 'package:dartz/dartz.dart';
import 'package:restaurant_dashboard/app/errors/server_errors.dart';
import 'package:restaurant_dashboard/features/auth/domain/entities/user_data_entity.dart';

import '../entities/auth_entity.dart';

abstract class BaseAuthRepository {
  Future<Either<ServerError, AuthEntity>> login({
    required String userName,
    required String password,
  });

  Future<Either<ServerError, AuthEntity>> register({
    required String displayName,
    required String username,
    required String password,
    required String phone,
  }); Future<Either<ServerError, void>> editProfile({
    required String displayName,
    required String username,
    required String image,
    required String phone,
  });

  Future<Either<ServerError, String?>> sendCode({
    required String phone,
  });

  Future<Either<ServerError, void>> reSendCode({
    required String phone,
  });

  Future<Either<ServerError, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Either<ServerError, bool>> checkUsername({
    required String username,
  });

  Future<Either<ServerError, UserDataEntity>> getUserData();
}
