import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/domain/auth/repository/auth_usecase.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class AccountScreenCubit extends Cubit<AppState> {
  AccountScreenCubit() : super(AppStateDefault());
  final _authUseCase = getIt<AuthUseCase>();
  void init() async {}

  Future<bool> logout() async {
    try {
      emit(AppStateLoading());
      await _authUseCase.logout();
      return true;
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
    return false;
  }
}
