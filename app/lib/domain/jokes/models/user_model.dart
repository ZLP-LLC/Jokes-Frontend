import 'package:flutter/material.dart';

enum UserRole {
  admin,
  user;

  static UserRole fromString(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'user':
        return UserRole.user;
      default:
        throw Exception('Unknown role');
    }
  }
}

@immutable
final class UserModel {
  final String username;
  final UserRole role;

  const UserModel({required this.username, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(username: json['username'], role: UserRole.fromString(json['role']));
}
