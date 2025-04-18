import 'dart:convert';

import 'package:restaurant_dashboard/features/auth/data/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Caching {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static put({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) return await prefs?.setInt(key, value);
    if (value is bool) return await prefs?.setBool(key, value);
    if (value is double) return await prefs?.setDouble(key, value);
    if (value is String) return await prefs?.setString(key, value);
  }

  static get({required String key}) {
    return prefs?.get(key);
  }

  static removeData({required String key}) {
    return prefs?.remove(key);
  }

  static Future<void> clearAllData() async {
    await prefs?.clear();
  }

  static AuthModel? getUser() {
    String? userPref = prefs?.getString("user_data");
    if (userPref == null) {
      return null;
    }
    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    return AuthModel.fromJson(userMap);
  }

  static Future<void> setUser(AuthModel model) async {
    await prefs?.setString("user_data", jsonEncode(model.toJson()));
  }

  static Future<void> removeUser() async {
    await prefs?.remove("user_data");
  }
}
