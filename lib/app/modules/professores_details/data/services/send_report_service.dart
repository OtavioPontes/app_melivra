import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/services/i_send_report_service.dart';

class SendReportService implements ISendReportService {
  final Dio _dio;

  SendReportService({
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
    } on DioException catch (_) {
      return const Left(
        ServerFailure(message: 'Erro ao enviar solicitação, tente novamente,'),
      );
    }
  }
}
