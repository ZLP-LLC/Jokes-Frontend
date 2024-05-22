import 'package:flutter/material.dart';
import 'package:zlp_jokes/features/home/home_screen.dart';
import 'package:zlp_jokes/features/joke_screen/joke_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // Routes.startScreen: (context) => const StartScreen(),
  // Routes.authScreen: (context) => const AuthScreen(initialIndex: 1),

  Routes.homeScreen: (context) => const HomeScreen(),

  // Routes.jokeScreen: (context) => const JokeScreen(),
};

sealed class Routes {
  // static const String authScreen = '/start/auth';

  static const String homeScreen = '/';

  // static const String jokeScreen = '/joke';
}
