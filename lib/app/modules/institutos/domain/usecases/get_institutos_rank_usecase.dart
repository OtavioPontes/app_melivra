import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/institutos/domain/repositories/i_instituto_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../ranking_institutos/domain/entities/ranking_config_entity.dart';

class GetInstitutosRankUsecase
    implements UseCase<RankingConfig, ParamsGetInstitutosRankUsecase> {
  final IInstitutoRepository _repository;

  GetInstitutosRankUsecase({
    required IInstitutoRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, RankingConfig>> call(
    ParamsGetInstitutosRankUsecase params,
  ) async {
    return _repository.getInstitutosRank(
      params.page,
      params.itemsPerPage,
    );
  }
}

class ParamsGetInstitutosRankUsecase extends IParams {
  final int? page;
  final int? itemsPerPage;

  ParamsGetInstitutosRankUsecase({
    this.page,
    this.itemsPerPage,
  });
}
