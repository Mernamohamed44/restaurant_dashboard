
import 'package:restaurant_dashboard/features/auth/data/models/user_data_model.dart';

import '../models/auth_model.dart';

abstract class BaseRemoteAuthDataSource {
  Future<AuthModel> login({
    required String userName,
    required String password,
  });

  Future<AuthModel> register({
    required String displayName,
    required String username,
    required String password,
    required String phone,
  });

  changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<UserDataModel> getUserData();

  Future<String?> sendCode({
    required String phone,
  });

  Future<void> reSendCode({
    required String phone,
  });

  Future<bool> checkUsername({
    required String username,
  });
}
