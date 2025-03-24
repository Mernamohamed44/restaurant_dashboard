import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required super.displayName,
    required super.id,
    required super.role,
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      displayName: json["displayName"],
      id: json["_id"],
      role: json["role"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "displayName": displayName,
      "_id": id,
      "role": role,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    };
  }
}
