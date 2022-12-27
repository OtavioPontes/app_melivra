import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:app_melivra/app/modules/institutos/domain/repositories/i_instituto_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

class GetInstitutosRankUsecase
    implements UseCase<List<Instituto>, ParamsGetInstitutosRankUsecase> {
  final IInstitutoRepository _repository;

  GetInstitutosRankUsecase({
    required IInstitutoRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, List<Instituto>>> call(params) async {
    return await _repository.getInstitutosRank(
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
