import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/app_state.dart';
import 'package:zlp_jokes/features/grid_screen/data/models/joke_model.dart';
import 'package:zlp_jokes/features/joke_screen/bloc/joke_screen_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/widgets/joke_card.dart';
import 'package:zlp_jokes/utils/app_colors.dart';

class JokeScreen extends StatelessWidget {
  final int jokeId;
  const JokeScreen({super.key, required this.jokeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JokeScreenCubit()..loadJoke(jokeId),
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text(
            'Анекдот',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 1,
                  child: SizedBox.shrink(),
                ),
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      BlocBuilder<JokeScreenCubit, AppState>(
                        builder: (context, state) {
                          if (state is AppStateSuccess<JokeModel>) {
                            return JokeCard(jokeModel: state.data!);
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
