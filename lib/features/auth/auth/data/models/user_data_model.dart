import 'package:restaurant_dashboard/features/auth/auth/domain/entities/user_data_entity.dart';

class UserDataModel extends UserDataEntity {
  UserDataModel(
      {required super.role,
      required super.preferredLanguage,
      required super.sId,
      required super.displayName,
      required super.username,
      required super.phone,
      required super.image,
      required super.projects,
      required super.createdAt,
      required super.updatedAt,
      required super.passwordChangeAt});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        role: json['role'],
        preferredLanguage: json['preferredLanguage'],
        sId: json['_id'],
        displayName: json['displayName'],
        username: json['username'],
        phone: json['phone'],
        image: json['image'],
        projects: json['projects'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        passwordChangeAt: json['passwordChangeAt']);
  }
}
