import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_model.dart';
import 'package:zlp_jokes/features/home/grid_screen/widgets/simple_joke_card.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key, required this.jokes});
  final List<JokeModel> jokes;
  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  late ScrollController _scrollController;
  double _savedScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: _savedScrollPosition,
    );
    _scrollController.addListener(_saveScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  void _saveScrollPosition() {
    _savedScrollPosition = _scrollController.position.pixels;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenCubit, AppState>(
      listener: (context, state) {
        if (state is AppStateSuccess<List<JokeModel>>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.jumpTo(_savedScrollPosition);
          });
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 40),
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
                        StaggeredGrid.count(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 36,
                          mainAxisSpacing: 36,
                          children: widget.jokes.map((joke) {
                            return SimpleJokeCard(jokeModel: joke);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
