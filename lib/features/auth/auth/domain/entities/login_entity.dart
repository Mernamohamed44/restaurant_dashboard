import '../../data/models/user_model.dart';

class UserEntity {
  final String displayName;
  final String id;
  final String username;
  String accessToken;
  String refreshToken;

  UserEntity({
    required this.displayName,
    required this.id,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });

  UserModel copyWith({
    String? id,
    String? accessToken,
    String? refreshToken,
    String? displayName,
    String? username,
  }) {
    return UserModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
