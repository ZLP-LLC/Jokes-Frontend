import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/account/cubit/joke_push_cubit.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/app_state.dart';
import 'package:zlp_jokes/utils/text_styles.dart';

class JokePushWidget extends StatefulWidget {
  const JokePushWidget({
    super.key,
  });

  @override
  State<JokePushWidget> createState() => _JokePushWidgetState();
}

class _JokePushWidgetState extends State<JokePushWidget> {
  late TextEditingController _jokeController;

  @override
  void initState() {
    super.initState();
    _jokeController = TextEditingController();
  }

  @override
  void dispose() {
    _jokeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JokePushCubit(),
      child: BlocBuilder<JokePushCubit, AppState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(flex: 1, child: SizedBox.shrink()),
              Flexible(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.color800,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.color900,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Добавить анекдот',
                                  style: TextStyle(
                                    color: AppColors.color200,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Material(
                                color: AppColors.color400,
                                child: TextField(
                                  style: TextStyles.defaultJokeStyle,
                                  controller: _jokeController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: SizedBox(
                                  width: 160,
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
                                      if (_jokeController.text.trim().isEmpty) {
                                        return;
                                      }
                                      final result =
                                          await context.read<JokePushCubit>().pushJoke(_jokeController.text.trim());
                                      Navigator.of(context).pop(result);
                                    },
                                    child: const Text(
                                      textAlign: TextAlign.center,
                                      'Добавить',
                                      style: TextStyle(
                                        color: AppColors.color200,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
