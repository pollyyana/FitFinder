// lib/core/services/api_client.dart
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'http://192.168.15.6:8080', // seu servidor local
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[API REQUEST] => ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('[API RESPONSE] => ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (e, handler) {
          print('[API ERROR] => ${e.response?.statusCode} ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
