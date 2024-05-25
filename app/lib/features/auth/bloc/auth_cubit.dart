import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/auth/auth_usecase.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class AuthCubit extends Cubit<AppState> {
  AuthCubit() : super(AppStateDefault());

  final _authUseCase = getIt<AuthUseCase>();

  Future<bool> tryAuth({required String login, required String password}) async {
    try {
      emit(AppStateLoading());
      await _authUseCase.signUp(username: login, password: password);
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
    try {
      await _authUseCase.signIn(username: login, password: password);
      return true;
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
    return false;
  }

  Future<bool> isAuthorized() async {
    try {
      final status = _authUseCase.isAuthorized();
      return status;
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
      return false;
    }
  }
}
