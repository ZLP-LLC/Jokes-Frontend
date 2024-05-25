import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void confingureDependecies() {
  getIt.init();
  // getIt<AuthUseCase>().init();
}
