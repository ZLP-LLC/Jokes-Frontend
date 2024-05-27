import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/auth/bloc/auth_cubit.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _obscureText = true;
  late TextEditingController _passwordController;
  late TextEditingController _loginController;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _loginController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool value) {
        context.read<HomeScreenCubit>().loadJokes();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Авторизация',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 40),
          child: BlocBuilder<AuthCubit, AppState>(
            builder: (context, state) {
              if (state is AppStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(flex: 1, child: SizedBox.shrink()),
                  Flexible(
                    flex: 6,
                    child: Container(
                      width: 480,
                      height: 280,
                      decoration: BoxDecoration(
                        color: AppColors.color200,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: AppColors.color900,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                TextFormField(
                                  controller: _loginController,
                                  decoration: const InputDecoration(
                                    labelText: 'Логин',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Пароль',
                                    suffixIcon: InkWell(
                                      onTap: () => setState(() {
                                        _obscureText = !_obscureText;
                                      }),
                                      child: const Icon(
                                        size: 24,
                                        Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _obscureText,
                                ),
                              ],
                            ),
                            // const SizedBox(height: 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
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
                                        final login = _loginController.text.trim();
                                        final password = _passwordController.text.trim();
                                        if (login.isNotEmpty && password.isNotEmpty) {
                                          if (password.length >= 8) {
                                            final success = await context
                                                .read<AuthCubit>()
                                                .tryAuth(login: login, password: password);

                                            if (success && mounted) {
                                              context.read<HomeScreenCubit>().loadJokes();
                                              Navigator.of(context).pop();
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 2),
                                                content: Text('Пароль должен быть не менее 8 символов'),
                                              ),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: Text('Заполните все поля'),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Войти',
                                        style: TextStyle(
                                          color: AppColors.color800,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            // return const SizedBox.shrink()
          ),
        ),
      ),
    );
  }
}
