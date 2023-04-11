import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/i_professor_repository.dart';

class GetProfessorGradesCountUsecase
    implements UseCase<int, ParamsGetProfessorGradesCountUsecase> {
  final IProfessorRepository _repository;

  GetProfessorGradesCountUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, int>> call(
    ParamsGetProfessorGradesCountUsecase params,
  ) async {
    return _repository.getProfessorGradesCount(
      id: params.id,
    );
  }
}

class ParamsGetProfessorGradesCountUsecase extends IParams {
  final int id;

  ParamsGetProfessorGradesCountUsecase({
    required this.id,
  });
}
