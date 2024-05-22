import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zlp_jokes/features/grid_screen/bloc/grid_screen_cubit.dart';
import 'package:zlp_jokes/features/grid_screen/data/models/joke_model.dart';
import 'package:zlp_jokes/features/grid_screen/widgets/simple_joke_card.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth < 800 ? 1 : 2;
            return Row(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8, bottom: 4),
                            child: Text(
                              'Все анекдоты',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 2,
                              height: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      BlocBuilder<GridScreenCubit, AppState>(
                        builder: (context, state) {
                          if (state is AppStateLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AppStateWrong) {
                            if (state is AppStateError) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                          } else if (state is AppStateSuccess<List<JokeModel>>) {
                            return StaggeredGrid.count(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 36,
                              mainAxisSpacing: 36,
                              children: state.data!.map((joke) {
                                return SimpleJokeCard(jokeModel: joke);
                              }).toList(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
