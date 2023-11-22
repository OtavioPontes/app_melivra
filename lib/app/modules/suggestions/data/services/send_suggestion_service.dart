import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:app_melivra/app/modules/suggestions/domain/services/i_send_suggestion_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SendSuggestionService implements ISendSuggestionService {
  final Dio _dio;

  SendSuggestionService({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<Either<IFailure, void>> call({required String suggestion}) async {
    try {
      await _dio.post(
        Endpoints.suggestions,
        data: {
          'description': suggestion,
        },
      );
      return Right(voidRight);
    } on DioException catch (_) {
      return const Left(
        ServerFailure(message: 'Erro ao enviar sugestão, tente novamente,'),
      );
    }
  }
}
