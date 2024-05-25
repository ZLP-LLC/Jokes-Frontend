import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/domain/jokes/repository/jokes_repository.dart';
import 'package:zlp_jokes/domain/rating/repository/rating_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class JokeScreenCubit extends Cubit<AppState> {
  JokeScreenCubit({required this.jokeId}) : super(AppStateDefault()) {
    loadJoke(jokeId);
  }
  final _jokesRepository = getIt<JokesRepository>();
  final _ratingRepository = getIt<RatingRepository>();
  final int jokeId;

  bool isRatedNow = false;

  void loadJoke(int jokeId) async {
    try {
      emit(AppStateLoading());
      final joke = await _jokesRepository.getJokeById(jokeId);
      jokeId = joke.id;
      emit(AppStateSuccess(joke));
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }

  void rateJoke(double rating) async {
    try {
      emit(AppStateLoading());
      await _ratingRepository.rateJoke(jokeId, rating);
      isRatedNow = true;
      loadJoke(jokeId);
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }
}
