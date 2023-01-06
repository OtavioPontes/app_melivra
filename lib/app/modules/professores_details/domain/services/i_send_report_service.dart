import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ISendReportService {
  Future<Either<IFailure, void>> call({
    required String description,
    required int id,
  });
}
