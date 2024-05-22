import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/joke_screen/bloc/joke_screen_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/widgets/joke_card.dart';
import 'package:zlp_jokes/utils/app_colors.dart';

class JokeScreen extends StatelessWidget {
  final int jokeId;
  const JokeScreen({super.key, required this.jokeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => JokeScreenCubit(),
        child: Scaffold(
          appBar: AppBar(
              // title: const Text(
              //   'Анекдоты',
              //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
              // ),
              ),
          body: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 1,
                  child: SizedBox.shrink(),
                ),
                Flexible(
                  flex: 6,
                  child: Column(
                    children: [
                      Text(jokeId.toString()),
                      // JokeCard(joke: joke),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
