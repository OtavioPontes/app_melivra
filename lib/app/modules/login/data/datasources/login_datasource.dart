import 'dart:convert';

import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/modules/login/data/models/user_model.dart';
import 'package:dio/dio.dart';

import 'i_login_datasource.dart';

class LoginDatasource implements ILoginDatasource {
  final Dio _dio;
  LoginDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/',
        data: json.encode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      return UserModel.fromMap(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Erro ao Logar usuário',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: 'Erro ao Logar usuário');
    }
  }

  @override
  Future<UserModel> oauthLogin({
    required String idToken,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/oauth/',
        data: json.encode(
          {
            "idToken": idToken,
          },
        ),
      );
      return UserModel.fromMap(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Erro ao Logar usuário',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: 'Erro ao Logar usuário');
    }
  }
}
