import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/domain/jokes/repository/jokes_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class HomeScreenCubit extends Cubit<AppState> {
  HomeScreenCubit() : super(AppStateDefault()) {
    loadJokes();
  }
  final _repository = getIt<JokesRepository>();

  Future<void> loadJokes() async {
    try {
      emit(AppStateLoading());
      final jokes = await _repository.getJokes();
      emit(AppStateSuccess(jokes.reversed.toList()));
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }
}
