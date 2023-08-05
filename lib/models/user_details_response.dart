import 'package:test_app/models/user.dart';

/// Модель детальної відповіді про користувача. Містить інформацію про користувача та підтримку.

class UserDetailsResponse {
  User? user;
  Support? support;

  UserDetailsResponse({this.user, this.support});

  UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    user = json['data'] != null ? User?.fromJson(json['data']) : null;
    support =
        json['support'] != null ? Support?.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = user!.toJson();
    data['support'] = support!.toJson();
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}
