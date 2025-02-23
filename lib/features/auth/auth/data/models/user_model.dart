import '../../domain/entities/login_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.displayName,
    required super.id,
    required super.username,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json["displayName"],
      id: json["_id"],
      username: json["username"],
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "displayName": displayName,
      "_id": id,
      "username": username,
      "access_token": accessToken,
      "refresh_token": refreshToken,
    };
  }
}
