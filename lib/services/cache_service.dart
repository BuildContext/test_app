import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../models/user_details_response.dart';

/// Зберігає дані в кеші:
///
/// [cacheUsers] - список користувачів
/// [getCachedUsers] - отримати з кешу
/// [cacheUser] - користувач
/// [getCachedUser] - отримати користувача з кешу
/// Використовує [SharedPreferences].

class CacheService {
  static const _cachedUsersKey = 'CACHED_USERS';

  late SharedPreferences prefs;

  CacheService() {
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void cacheUsers(List<User> users) {
    final jsonUsers = users.map((user) => jsonEncode(user.toJson())).toList();
    prefs.setStringList(_cachedUsersKey, jsonUsers);
  }

  List<User> getCachedUsers() {
    final jsonUsers = prefs.getStringList(_cachedUsersKey) ?? [];
    return jsonUsers.map((json) => User.fromJson(jsonDecode(json))).toList();
  }

  void cacheUser(UserDetailsResponse data) {
    final jsonUser = jsonEncode(data);
    if (data.user?.id == null) return;
    prefs.setString('CACHED_USER_${data.user!.id}', jsonUser);
  }

  UserDetailsResponse? getCachedUser(int id) {
    final json = prefs.getString('CACHED_USER_$id');
    return json == null ? null : UserDetailsResponse.fromJson(jsonDecode(json));
  }
}
