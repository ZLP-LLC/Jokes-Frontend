// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:zlp_jokes/core/auth/auth_token_exp.dart' as _i4;
import 'package:zlp_jokes/core/auth/auth_usecase.dart' as _i8;
import 'package:zlp_jokes/core/auth/server_auth_datasource.dart' as _i9;
import 'package:zlp_jokes/core/http_api/http_api.dart' as _i6;
import 'package:zlp_jokes/core/network_handler/network_handler.dart' as _i3;
import 'package:zlp_jokes/core/secure_storage/secure_storage.dart' as _i11;
import 'package:zlp_jokes/core/services/network_service.dart' as _i7;
import 'package:zlp_jokes/features/grid_screen/data/repository/jokes_repository.dart'
    as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final secureStorage = _$SecureStorage();
    gh.factory<_i3.NetworkHandler>(() => _i3.NetworkHandler());
    gh.singleton<_i4.AuthTokenExpirationController>(
        () => _i4.AuthTokenExpirationController());
    gh.lazySingleton<_i5.FlutterSecureStorage>(() => secureStorage.instance);
    gh.factory<_i6.HttpAPI>(() => _i6.HttpAPI(
          gh<_i4.AuthTokenExpirationController>(),
          gh<_i5.FlutterSecureStorage>(),
        ));
    gh.factory<_i7.NetworkService>(
        () => _i7.NetworkService(httpAPI: gh<_i6.HttpAPI>()));
    gh.factory<_i8.AuthUseCase>(() => _i8.AuthUseCase(
          serverAuthDataSource: gh<_i9.ServerAuthDataSource>(),
          secureStorage: gh<_i5.FlutterSecureStorage>(),
          authTokenExpirationController:
              gh<_i4.AuthTokenExpirationController>(),
        ));
    gh.factory<_i10.JokesRepository>(
        () => _i10.JokesRepository(gh<_i7.NetworkService>()));
    return this;
  }
}

class _$SecureStorage extends _i11.SecureStorage {}
