import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/core/http_api/http_api.dart';
import 'package:zlp_jokes/core/network_handler/network_handler.dart';
import 'package:zlp_jokes/utils/app_state.dart';

@injectable
class NetworkService {
  final Dio _dio;

  NetworkService({
    required HttpAPI httpAPI,
  }) : _dio = httpAPI.newDio();

  Future<AppStateSuccess<T>> delete<T>(String endpoint) async {
    final result = await _dio.delete(endpoint);

    return NetworkHandler.parseResult(result);
  }

  Future<AppStateSuccess<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final result = await _dio.get(
      endpoint,
      queryParameters: queryParameters,
    );

    return NetworkHandler.parseResult(result);
  }

  Future<AppStateSuccess<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    final result = await _dio.post(
      endpoint,
      queryParameters: queryParameters,
      data: data,
    );

    return NetworkHandler.parseResult(result);
  }

  Future<AppStateSuccess<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    final result = await _dio.put(
      endpoint,
      queryParameters: queryParameters,
      data: data,
    );

    return NetworkHandler.parseResult(result);
  }

  Future<AppStateSuccess<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    final result = await _dio.patch(
      endpoint,
      queryParameters: queryParameters,
      data: data,
    );

    return NetworkHandler.parseResult(result);
  }
}
