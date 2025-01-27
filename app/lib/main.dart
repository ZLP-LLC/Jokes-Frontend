import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/features/auth/bloc/auth_cubit.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/joke_screen.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  confingureDependecies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _app = MaterialApp(
    title: 'ZLP Смешнульки',
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('ru'),
      Locale('en'),
    ],
    initialRoute: Routes.homeScreen,
    routes: routes,
    onGenerateRoute: (settings) {
      final Uri uri = Uri.parse(settings.name!);
      if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'joke') {
        final id = int.tryParse(uri.pathSegments[1]);
        if (id != null) {
          return MaterialPageRoute(builder: (context) => JokeScreen(jokeId: id), settings: settings);
        }
      }
      return null;
    },
    theme: ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColors.color900,
        secondary: AppColors.color400,
        onPrimary: AppColors.color400,
        onSecondary: AppColors.color900,
      ),
      appBarTheme: const AppBarTheme(
        color: AppColors.color900,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.color200),
        centerTitle: true,
      ),
      scaffoldBackgroundColor: Colors.white,
      shadowColor: const Color(0x00000000),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.color900,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.color900,
          ),
        ),
        focusColor: AppColors.color900,
        floatingLabelStyle: TextStyle(color: AppColors.color900),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: AppColors.color400,
        selectionHandleColor: AppColors.color400,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => HomeScreenCubit()),
      ],
      child: _app,
    );
  }
}
