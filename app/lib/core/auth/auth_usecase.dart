import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/core/auth/auth_token_exp.dart';
import 'package:zlp_jokes/core/auth/models/login_request.dart';
import 'package:zlp_jokes/core/auth/models/register_request.dart';
import 'package:zlp_jokes/core/auth/server_auth_datasource.dart';

@injectable
class AuthUseCase {
  final ServerAuthDataSource _serverAuthDataSource;
  final FlutterSecureStorage _secureStorage;
  final AuthTokenExpirationController _authTokenExpirationController;

  StreamSubscription<bool>? _expTokenSub;

  AuthUseCase({
    required ServerAuthDataSource serverAuthDataSource,
    required FlutterSecureStorage secureStorage,
    required AuthTokenExpirationController authTokenExpirationController,
  })  : _serverAuthDataSource = serverAuthDataSource,
        _secureStorage = secureStorage,
        _authTokenExpirationController = authTokenExpirationController;

  void init() {
    _expTokenSub ??= _authTokenExpirationController.expirationTokenStream.listen((_) => _logout());
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    final userLoginDTO = UserLoginRequestDTO(
      username: username,
      password: password,
    );

    final token = await _serverAuthDataSource.signIn(
      userLoginDTO,
    );

    await _secureStorage.write(key: 'token', value: token);
  }

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    final userRegistrationDTO = UserRegistrationRequestDTO(
      username: username,
      password: password,
    );

    await _serverAuthDataSource.signUp(
      userRegistrationDTO,
    );
  }

  Future<void> _logout() async {
    await _secureStorage.delete(key: 'token');
  }

  Future<bool> isAuthorized() async {
    final token = await _secureStorage.read(key: 'token');
    return token != null;
  }

  void dispose() {
    _expTokenSub?.cancel();
    _expTokenSub = null;
  }
}
