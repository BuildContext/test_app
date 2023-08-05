import 'user.dart';

/// Модель для відповіді API із сторінкою користувачів.

class UsersPageResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<User> data;

  UsersPageResponse(
      {required this.page,
      required this.perPage,
      required this.total,
      required this.totalPages,
      required this.data});

  factory UsersPageResponse.fromJson(Map<String, dynamic> json) {
    return UsersPageResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: (json['data'] as List).map((e) => User.fromJson(e)).toList(),
    );
  }
}
