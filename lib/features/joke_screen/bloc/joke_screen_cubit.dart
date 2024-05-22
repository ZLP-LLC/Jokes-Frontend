import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/app_state.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/features/grid_screen/data/repository/jokes_repository.dart';

class JokeScreenCubit extends Cubit<AppState> {
  JokeScreenCubit() : super(AppStateDefault());
  final _repository = getIt<JokesRepository>();

  void loadJoke(int jokeId) {
    try {
      emit(AppStateLoading());
      final joke = _repository.getJokeById(jokeId);
      emit(AppStateSuccess(joke));
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }
}
