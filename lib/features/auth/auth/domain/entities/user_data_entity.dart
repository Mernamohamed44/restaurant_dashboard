import 'package:restaurant_dashboard/features/auth/auth/data/models/user_data_model.dart';


class UserDataEntity {
  String? role;
  String? preferredLanguage;
  String? sId;
  String? displayName;
  String? username;
  String? phone;
  String? image;
  List? projects;
  String? createdAt;
  String? updatedAt;
  String? passwordChangeAt;

  UserDataEntity(
      {required this.displayName,
      required this.role,
      required this.preferredLanguage,
      required this.sId,
      required this.username,
      required this.phone,
      required this.image,
      required this.projects,
      required this.createdAt,
      required this.updatedAt,
      required this.passwordChangeAt});

  UserDataModel copyWith({
    String? role,
    String? preferredLanguage,
    String? sId,
    String? displayName,
    String? username,
    String? phone,
    String? image,
    List? projects,
    String? createdAt,
    String? updatedAt,
    String? passwordChangeAt,
  }) {
    return UserDataModel(
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      displayName: displayName ?? this.displayName,
      role: username ?? this.role,
      projects: projects ?? this.projects,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      image: image ?? this.image,
      sId: sId ?? this.sId,
      createdAt: createdAt ?? this.createdAt,
      passwordChangeAt: passwordChangeAt ?? this.passwordChangeAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
