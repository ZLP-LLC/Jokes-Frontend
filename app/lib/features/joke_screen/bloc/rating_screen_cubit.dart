import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/domain/rating/repository/rating_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class RatingScreenCubit extends Cubit<AppState> {
  RatingScreenCubit() : super(AppStateDefault());
  final _ratingRepository = getIt<RatingRepository>();

  Future<void> rateJoke({
    required int jokeId,
    required double rating,
  }) async {
    try {
      emit(AppStateLoading());
      await _ratingRepository.rateJoke(jokeId, rating);
      emit(AppStateSuccess());
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }
}
