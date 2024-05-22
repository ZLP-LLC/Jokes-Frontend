import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/core/auth/auth_token_exp.dart';

@injectable
class HttpAPI {
  final AuthTokenExpirationController _authTokenExpirationController;
  final FlutterSecureStorage _flutterSecureStorage;

  late final String _baseURLHost = 'https://jokes.zlp.ooo/api/v1';

  HttpAPI(
    this._authTokenExpirationController,
    this._flutterSecureStorage,
  );
  Dio newDio({
    int receiveTimeout = 5000,
    int connectTimeout = 5000,
  }) {
    final options = BaseOptions(baseUrl: _baseURLHost);
    options.receiveTimeout = Duration(milliseconds: receiveTimeout);
    options.connectTimeout = Duration(milliseconds: connectTimeout);
    options.sendTimeout = Duration(milliseconds: receiveTimeout);
    final dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        //Интерсептор подстановки авторизации
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          final token = await _flutterSecureStorage.read(key: 'token');
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: ((error, handler) {
          if (error.response?.statusCode == 401) {
            _authTokenExpirationController.tokenExpired();
          }
          handler.next(error);
        }),
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }
}
