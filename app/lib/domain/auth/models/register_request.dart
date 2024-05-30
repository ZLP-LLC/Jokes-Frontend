import 'package:flutter/foundation.dart';

@immutable
final class UserRegistrationRequestDTO {
  final String username;
  final String password;

  const UserRegistrationRequestDTO({
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
