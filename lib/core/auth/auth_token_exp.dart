import 'dart:async';

import 'package:injectable/injectable.dart';

@singleton
class AuthTokenExpirationController {
  final StreamController<bool> _expirationTokenStreamController;

  Stream<bool> get expirationTokenStream => _expirationTokenStreamController.stream;

  AuthTokenExpirationController() : _expirationTokenStreamController = StreamController.broadcast();

  void tokenExpired() => _expirationTokenStreamController.add(true);
}
