import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/domain/jokes/repository/jokes_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class JokeScreenCubit extends Cubit<AppState> {
  JokeScreenCubit() : super(AppStateDefault());
  final _repository = getIt<JokesRepository>();

  void loadJoke(int jokeId) async {
    try {
      emit(AppStateLoading());
      final joke = await _repository.getJokeById(jokeId);
      emit(AppStateSuccess(joke));
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }
}
