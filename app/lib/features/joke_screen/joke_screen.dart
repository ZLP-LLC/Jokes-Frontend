import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_model.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/bloc/joke_screen_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/widgets/joke_card.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class JokeScreen extends StatefulWidget {
  final int jokeId;
  const JokeScreen({super.key, required this.jokeId});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeScreenCubit>().loadJokes();
        return true;
      },
      child: BlocProvider(
        create: (context) => JokeScreenCubit(jokeId: widget.jokeId),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Анекдот №${widget.jokeId}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
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
      ),
    );
  }
}
