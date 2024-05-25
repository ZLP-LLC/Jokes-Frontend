import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/auth/bloc/auth_cubit.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/features/home/grid_screen/widgets/grid_screen.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().loadJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Анекдоты',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
        ),
        actions: [
          BlocBuilder<HomeScreenCubit, AppState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  final bool isAuthorized = await context.read<AuthCubit>().isAuthorized();
                  Navigator.pushNamed(
                    context,
                    isAuthorized ? '/account' : '/auth',
                  );
                },
                icon: const Icon(Icons.account_circle),
              );
            },
          ),
        ],
      ),
      body: const GridScreen(),
    );
  }
}
