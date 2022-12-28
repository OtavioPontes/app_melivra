import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../ranking_institutos/domain/entities/ranking_config_entity.dart';
import '../entities/institutos_response.dart';

abstract class IInstitutoRepository {
  Future<Either<IFailure, InstitutosResponse>> getInstitutos([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]);

  Future<Either<IFailure, RankingConfig>> getInstitutosRank([
    int? page,
    int? itemsPerPage,
  ]);

  Future<Either<IFailure, Instituto>> getInstitutoDetails({required int id});
}
