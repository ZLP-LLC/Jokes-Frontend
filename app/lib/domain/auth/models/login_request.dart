import 'package:flutter/foundation.dart';

@immutable
final class UserLoginRequestDTO {
  final String username;
  final String password;

  const UserLoginRequestDTO({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
