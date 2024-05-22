library helpers;

import 'package:dio/dio.dart' show DioException;

abstract class AppState {
  static AppStateWrong catchErrorHandler(Object? error, {String? details}) {
    if (error == null) {
      return AppStateError('unidentified error', details: details);
    }
    if (error is AppStateWrong) {
      return error;
    } else if (error is DioException) {
      return AppStateError(error.toString(), details: details);
    } else if (error is TypeError) {
      return AppStateError(error.toString(), details: details);
    }
    return AppStateError(error.toString(), details: details);
  }
}

class AppStateSuccess<T> implements AppState {
  T? data;

  AppStateSuccess([this.data]);

  bool isEmpty() {
    return data == null;
  }

  T get() {
    return data!;
  }
}

class AppStateWrong extends AppState implements Exception {
  final String message;
  final String? key;
  final String? details;

  AppStateWrong(this.message, {this.key, this.details});

  @override
  String toString() {
    return key != null ? '[$key] $message' : message;
  }
}

class AppStateError extends AppStateWrong {
  AppStateError(String message, {String? key, String? details}) : super(message, key: key, details: details);
}

class AppStateWarning extends AppStateWrong {
  AppStateWarning(String message, {String? key, String? details}) : super(message, key: key, details: details);
}

class AppStateDefault extends AppState {}

class AppStateLoading extends AppState {}
