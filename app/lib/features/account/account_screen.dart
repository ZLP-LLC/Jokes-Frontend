import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/domain/user/models/user_model.dart';
import 'package:zlp_jokes/features/account/cubit/account_cubit.dart';
import 'package:zlp_jokes/features/account/widgets/joke_push_widget.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
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
        create: (context) => AccountScreenCubit(),
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
              } else if (state is AppStateSuccess<UserModel>) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(flex: 2, child: SizedBox.shrink()),
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.data!.role == UserRole.admin) ...[
                            SizedBox(
                              height: 40,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    const BorderSide(
                                      color: AppColors.color400,
                                      width: 2.5,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await showDialog(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return JokePushWidget();
                                    },
                                  );
                                },
                                child: const Text(
                                  'Добавить анекдот',
                                  style: TextStyle(
                                    color: AppColors.color800,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                          ],
                          SizedBox(
                            height: 40,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                side: WidgetStateProperty.all(
                                  const BorderSide(
                                    color: AppColors.color400,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final success = await context.read<AccountScreenCubit>().logout();
                                if (success && mounted) {
                                  context.read<HomeScreenCubit>().loadJokes();
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Выйти',
                                style: TextStyle(
                                  color: AppColors.color800,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
