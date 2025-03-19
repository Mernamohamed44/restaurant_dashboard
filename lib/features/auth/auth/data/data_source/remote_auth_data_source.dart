import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/app/network/dio.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/features/auth/auth/data/models/user_data_model.dart';

import '../models/auth_model.dart';
import 'base_remote_auth_data_source.dart';

class RemoteAuthDataSource extends BaseRemoteAuthDataSource {
  final dioManager = DioManager();

  @override
  Future<AuthModel> login({
    required String userName,
    required String password,
  }) async {
    final Response response = await dioManager.post(
      ApiConstants.login,
      data: {
        "username": userName,
        "password": password,
      },
    );
    return AuthModel.fromJson(response.data);
  }

  @override
  Future<AuthModel> register({
    required String displayName,
    required String username,
    required String password,
    required String phone,
  }) async {
    final Response response = await dioManager.post(
      ApiConstants.register,
      data: {
        "displayName": displayName,
        "username": username,
        "password": password,
        "phone": phone,
        "image": '',
      },
    );
    return AuthModel.fromJson(response.data);
  }

  @override
  Future<String?> sendCode({
    required String phone,
  }) async {
    final Response response = await dioManager.post(
      ApiConstants.send,
      data: {
        "phone": phone,
      },
    );

    return response.data["verificationId"];
  }

  @override
  Future<void> reSendCode({
    required String phone,
  }) async {
    await dioManager.post(
      ApiConstants.resend,
      data: {
        "phone": phone,
      },
    );
  }

  @override
  Future<bool> checkUsername({
    required String username,
  }) async {
    final Response response = await dioManager.get(
      ApiConstants.checkUsername,
      queryParameters: {
        "username": username,
      },
    );

    return response.data["success"] ?? false;
  }

  @override
  Future<UserDataModel> getUserData() async {
    final Response response = await dioManager.get(
      ApiConstants.profile,
    );
    return UserDataModel.fromJson(response.data);
  }

  @override
  changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    await dioManager.post(
      ApiConstants.changePassword,
      data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );
  }
}
