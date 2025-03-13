import '../../data/models/auth_model.dart';

class AuthEntity {
  final String displayName;
  final String id;
  final String role;
  String accessToken;
  String refreshToken;

  AuthEntity({
    required this.displayName,
    required this.id,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });

  AuthModel copyWith({
    String? id,
    String? accessToken,
    String? refreshToken,
    String? displayName,
    String? username,
  }) {
    return AuthModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      role: username ?? this.role,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
