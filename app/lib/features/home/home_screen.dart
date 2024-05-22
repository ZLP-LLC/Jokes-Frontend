import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/account/account_screen.dart';
import 'package:zlp_jokes/features/home/grid_screen/bloc/grid_screen_cubit.dart';
import 'package:zlp_jokes/features/home/grid_screen/grid_screen.dart';
import 'package:zlp_jokes/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedIndex = 0;

final List<Widget> screens = [
  const GridScreen(),
  const AccountScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GridScreenCubit()..loadJokes(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Анекдоты',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
          ),
        ),
        body: const GridScreen(),
      ),
    );
  }
}
