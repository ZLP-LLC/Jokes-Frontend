import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/account/cubit/account_cubit.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool value) {
        context.read<HomeScreenCubit>().loadJokes();
      },
      child: BlocProvider(
        create: (context) => AccountScreenCubit()..init(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Аккаунт',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: Colors.white),
            ),
          ),
          body: BlocBuilder<AccountScreenCubit, AppState>(
            builder: (context, state) {
              if (state is AppStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: OutlinedButton(
                  onPressed: () async {
                    final success = await context.read<AccountScreenCubit>().logout();
                    if (success && mounted) {
                      context.read<HomeScreenCubit>().loadJokes();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Выйти'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
