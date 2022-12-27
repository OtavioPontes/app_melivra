import 'package:app_melivra/app/core/domain/entities/user.dart';
import 'package:app_melivra/app/modules/login/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class TokenInterceptor extends Interceptor {
  String? accessToken;

  TokenInterceptor({
    this.accessToken,
  });

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    accessToken = await _getAccessToken();
    if (accessToken == null) {
      return super.onRequest(options, handler);
    }

    final Map<String, dynamic> tokenHeader = {
      'Authorization': 'Bearer $accessToken'
    };

    options.headers.addAll(tokenHeader);

    return super.onRequest(options, handler);
  }

  Future<String?> _getAccessToken() async {
    final User? user = Hive.box('melivra').get('user') != null
        ? UserModel.fromMap(
            Map.from(
              (Hive.box('melivra').get('user')),
            ),
          ).toEntity()
        : null;
    return user?.token;
  }

  Future<void> initialize() async {
    accessToken = await _getAccessToken();
  }
}
