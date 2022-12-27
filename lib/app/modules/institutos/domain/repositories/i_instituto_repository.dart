import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IInstitutoRepository {
  Future<Either<IFailure, List<Instituto>>> getInstitutos([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]);

  Future<Either<IFailure, List<Instituto>>> getInstitutosRank([
    int? page,
    int? itemsPerPage,
  ]);

  Future<Either<IFailure, Instituto>> getInstitutoDetails({required int id});
}
