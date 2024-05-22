import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/utils/app_state.dart';

typedef JSONObject = Map<String, dynamic>;
typedef JSONList = List<JSONObject>;

@injectable
class NetworkHandler {
  static AppStateSuccess<T> parseResult<T>(
    Response<dynamic> resp,
  ) {
    switch (resp.statusCode) {
      case 200:
        final T rawData = resp.data;

        if (rawData is Map && rawData.containsKey('data')) {
          return AppStateSuccess<T>(rawData['data']);
        } else if (rawData is Map && rawData.containsKey('token')) {
          return AppStateSuccess<T>(rawData);
        }
        return AppStateSuccess<T>(rawData);
      case 204:
        return AppStateSuccess<T>();
      case 404:
        throw AppStateError(
          '[404] страница не найдена',
          key: 'server.error',
          details: resp.realUri.path,
        );
      case 400:
      case 422:
        Map<String, dynamic> rawData = resp.data;

        if (rawData.containsKey('errors')) {
          if (rawData['errors'] != null) {
            throw AppStateWarning('${resp.statusCode} ${resp.statusMessage}');
          }
        }

        throw AppStateError(
          '[422] server error: no content',
          key: 'server.error',
        );
      default:
        if (resp.data is String) {
          throw AppStateError(
            '[${resp.statusCode}] server error',
            details: resp.data,
            key: 'server.error',
          );
        }

        throw AppStateError(
          '[${resp.statusCode}] server error',
          key: 'server.error',
        );
    }
  }
}
