import 'package:app_melivra/app/core/network/api_url.dart';
import 'package:app_melivra/app/core/network/token_interceptor.dart';
import 'package:dio/dio.dart';

class DioConfig {
  final Dio _dio;
  TokenInterceptor? tokenInterceptor;

  DioConfig({
    required Dio dio,
  }) : _dio = dio;

  Future<void> init() async {
    final baseOptions = BaseOptions(
      baseUrl: Api.url,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    _dio.options = baseOptions;

    if (tokenInterceptor != null) {
      _dio.interceptors.add(tokenInterceptor!);
    } else {
      _dio.interceptors.add(TokenInterceptor());
    }
  }
}
