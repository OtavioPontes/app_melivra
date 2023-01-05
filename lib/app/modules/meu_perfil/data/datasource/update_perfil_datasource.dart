import 'package:app_melivra/app/modules/meu_perfil/data/datasource/i_update_perfil_datasource.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';

class UpdatePerfilDatasource implements IUpdatePerfilDatasource {
  final Dio _dio;
  UpdatePerfilDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> update({
    required String name,
    required String email,
  }) async {
    try {
      await _dio.put('/users/', data: {
        'email': email,
        'name': name,
      });
    } on DioError catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message: 'Erro na atualização, por favor tente novamente',
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
