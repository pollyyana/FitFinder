import 'package:dio/dio.dart';

class DioConnection {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: 'http://192.168.15.6:8080',
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return _instance!;
  }

  static void dispose() {
    _instance?.close();
    _instance = null;
  }
}
