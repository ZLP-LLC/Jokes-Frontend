import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/domain/jokes/repository/jokes_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class JokePushCubit extends Cubit<AppState> {
  JokePushCubit() : super(AppStateDefault());

  final _jokesRepository = getIt<JokesRepository>();

  Future<bool> pushJoke(String text) async {
    try {
      emit(AppStateLoading());
      await _jokesRepository.pushJoke(text);
      return true;
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
    return false;
  }
}
