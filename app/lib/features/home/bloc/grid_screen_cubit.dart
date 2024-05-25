import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/auth/auth_usecase.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/domain/jokes/repository/jokes_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class HomeScreenCubit extends Cubit<AppState> {
  HomeScreenCubit() : super(AppStateDefault());
  final _repository = getIt<JokesRepository>();
  final _authUseCase = getIt<AuthUseCase>();

  bool isAuthorized = false;

  void init() async {
    isAuthorized = !await _authUseCase.isAuthorized();

    loadJokes();
  }

  Future<void> loadJokes() async {
    try {
      emit(AppStateLoading());
      final jokes = await _repository.getJokes();
      emit(AppStateSuccess(jokes.reversed.toList()));
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }

  // Future<bool> checkAuthorized() async {
  //   final a =
  //   return a;
  // }
}
