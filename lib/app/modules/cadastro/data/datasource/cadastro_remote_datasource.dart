import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import 'i_cadastro_remote_datasource.dart';

class CadastroRemoteDatasource implements ICadastroRemoteDatasource {
  final Dio _dio;
  CadastroRemoteDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> register({
    required UserCreationModel user,
  }) async {
    try {
      await _dio.post(
        Endpoints.user,
        data: user.toMap(),
      );
    } on DioException catch (e) {
      throw ServerException(
        statusCode: e.response?.statusCode,
        message: e.response?.data['message'] ??
            'Erro no cadastro, por favor tente novamente',
      );
    } catch (e) {
      throw ServerException(
        message: 'Erro no cadastro, por favor tente novamente',
      );
    }
  }
}
