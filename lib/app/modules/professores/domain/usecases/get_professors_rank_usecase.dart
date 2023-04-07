import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/i_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/ranking_professors_config.dart';
import '../repositories/i_professor_repository.dart';

class GetProfessorsRankUsecase
    implements
        UseCase<RankingProfessorsConfig, ParamsGetProfessorsRankUsecase> {
  final IProfessorRepository _repository;

  GetProfessorsRankUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, RankingProfessorsConfig>> call(
    ParamsGetProfessorsRankUsecase params,
  ) async {
    return _repository.getProfessorsRank(
      page: params.page,
      itemsPerPage: params.itemsPerPage,
    );
  }
}

class ParamsGetProfessorsRankUsecase extends IParams {
  final int? page;
  final int? itemsPerPage;

  ParamsGetProfessorsRankUsecase({
    this.page,
    this.itemsPerPage,
  });
}
