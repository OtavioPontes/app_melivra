import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/endpoints.dart';
import 'i_recover_password_remote_datasource.dart';

class RecoverRemoteDatasource implements IRecoverRemoteDatasource {
  final Dio _dio;
  RecoverRemoteDatasource({
    required Dio dio,
  }) : _dio = dio;
  @override
  Future<void> sendValidationCode({required String email}) async {
    try {
      await _dio.post(
        Endpoints.sendValidationCode,
        data: {"email": email},
      );
    } on DioError catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message: e.response?.data['message'] ??
            'Erro no envio do código, por favor tente novamente',
      );
    } catch (e) {
      throw ServerException(
        message: 'Erro no envio do código, por favor tente novamente',
      );
    }
  }

  @override
  Future<void> validateCode({
    required String code,
    required String email,
  }) async {
    try {
      await _dio.post(
        Endpoints.validateCode,
        data: {
          "validation_code": code,
          'email': email,
        },
      );
    } on DioError catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message: e.response?.data['message'] ??
            'Erro na validação, por favor tente novamente',
      );
    } catch (e) {
      throw ServerException(
        message: 'Erro na validação, por favor tente novamente',
      );
    }
  }

  @override
  Future<void> updatePassword({
    required String code,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      await _dio.put(
        Endpoints.updatePassword,
        data: {
          "validation_code": code,
          'email': email,
          'password': password,
          'password_confirm': passwordConfirm,
        },
      );
    } on DioError catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message: e.response?.data['message'] ??
            'Erro na validação, por favor tente novamente',
      );
    } catch (e) {
      throw ServerException(
        message: 'Erro na validação, por favor tente novamente',
      );
    }
  }
}
