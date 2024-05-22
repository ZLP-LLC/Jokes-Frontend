import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/account/cubit/account_screen_states.dart';
import 'package:zlp_jokes/utils/app_state.dart';
// import 'package:zlp_jokes/utils/services/auth_service.dart';

class AccountScreenCubit extends Cubit<AppState> {
  AccountScreenCubit() : super(AppStateDefault());

  // final _authService = AuthService();
  void init() async {
    // await _authService.isAuthorized().then((isAthorized) {
    //   if (isAthorized) {
    //     checkUserPriveleges();
    //   } else {
    //     emit(AccountScreenStateLogIn());
    //   }
    // });
  }

  void checkUserPriveleges() {
    emit(AccountScreenStateRegister());
  }

  void switchToRegister() {
    emit(AccountScreenStateRegister());
  }

  void switchToLogIn() {
    emit(AccountScreenStateLogIn());
  }
}
