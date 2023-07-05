import 'package:app_melivra/app/core/network/token_interceptor.dart';
import 'package:dio/dio.dart';

class DioConfig {
  final Dio _dio;
  final String url;
  TokenInterceptor? tokenInterceptor;

  DioConfig({
    required this.url,
    required Dio dio,
  }) : _dio = dio;

  Future<void> init() async {
    final baseOptions = BaseOptions(
      baseUrl: url,
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    _dio.options = baseOptions;

    if (tokenInterceptor != null) {
      _dio.interceptors.add(tokenInterceptor!);
    } else {
      _dio.interceptors.add(TokenInterceptor());
    }
  }
}
