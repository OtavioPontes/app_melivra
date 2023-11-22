import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:app_melivra/app/modules/meu_perfil/data/datasource/i_perfil_datasource.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';

class PerfilDatasource implements IPerfilDatasource {
  final Dio _dio;
  PerfilDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> update({
    required String name,
    required String email,
  }) async {
    try {
      await _dio.put(
        Endpoints.user,
        data: {
          'email': email,
          'name': name,
        },
      );
    } on DioException catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message: 'Erro na atualização, por favor tente novamente',
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> delete() async {
    try {
      await _dio.delete(
        Endpoints.user,
      );
    } on DioException catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message: 'Erro na deleção do seu usuário, por favor tente novamente',
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
