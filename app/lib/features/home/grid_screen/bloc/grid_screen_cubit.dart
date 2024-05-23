import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/auth/auth_usecase.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/features/home/grid_screen/data/repository/jokes_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class GridScreenCubit extends Cubit<AppState> {
  GridScreenCubit() : super(AppStateDefault());
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
      emit(AppStateSuccess(jokes));
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }

  // Future<bool> checkAuthorized() async {
  //   final a =
  //   return a;
  // }
}
