import 'package:flutter/material.dart';
import 'package:zlp_jokes/features/auth/auth_screen.dart';
import 'package:zlp_jokes/features/home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Routes.authScreen: (context) => const AuthScreen(),
  Routes.homeScreen: (context) => const HomeScreen(),
};

sealed class Routes {
  static const String authScreen = '/auth';
  static const String homeScreen = '/';
}
