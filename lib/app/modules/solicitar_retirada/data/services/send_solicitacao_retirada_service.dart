import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:app_melivra/app/core/error/failures.dart';

import '../../domain/services/i_send_solicitacao_retirada_service.dart';

class SendSolicitacaoRetiradaService
    implements ISendSolicitacaoRetiradaService {
  final Dio _dio;

  SendSolicitacaoRetiradaService({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<Either<IFailure, void>> call({
    required String description,
    required int id,
  }) async {
    try {
      await _dio.post(
        Endpoints.exclusionRequests(id: id),
        data: {
          'description': description,
        },
      );
      return Right(voidRight);
    } on DioError catch (_) {
      return const Left(
        ServerFailure(message: 'Erro ao enviar solicitação, tente novamente,'),
      );
    }
  }
}
