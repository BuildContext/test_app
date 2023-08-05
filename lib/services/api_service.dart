import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_details_response.dart';
import '../models/user_page_response.dart';
import '../utils/connectivity_util.dart';

/// Надає методи для звернення до API:

/// [fetchUsersPage] - список користувачів
/// [fetchUserDetails] - деталі користувача
/// Перевіряє інтернет з'єднання.

class ApiService {
  static const baseUrl = 'https://reqres.in/api';

  Future<UsersPageResponse> fetchUsersPage({required int page}) async {
    await _checkInternetConnection();
    final url = Uri.parse('$baseUrl/users/?page=$page');
    final response = await http.get(url).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      final userResponse =
          UsersPageResponse.fromJson(jsonDecode(response.body));
      return userResponse;
    } else {
      throw Exception('Failed to load page');
    }
  }

  Future<UserDetailsResponse> fetchUserDetails(int id) async {
    await _checkInternetConnection();
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.get(url).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      final userDetails =
          UserDetailsResponse.fromJson(jsonDecode(response.body));
      return userDetails;
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<void> _checkInternetConnection() async {
    if (!await ConnectivityUtil.isConnected()) {
      throw Exception('not connection');
    }
  }
}
