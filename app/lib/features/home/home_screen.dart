import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/home/grid_screen/bloc/grid_screen_cubit.dart';
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GridScreenCubit()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Анекдоты',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
          ),
          actions: [
            BlocBuilder<GridScreenCubit, AppState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      context.read<GridScreenCubit>().isAuthorized ? '/auth' : '/account',
                      arguments: context.read<GridScreenCubit>().init,
                    );
                  },
                  icon: const Icon(Icons.account_circle),
                );
              },
            ),
          ],
        ),
        body: const GridScreen(),
      ),
    );
  }
}
