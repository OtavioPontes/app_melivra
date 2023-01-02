import 'package:app_melivra/app/core/domain/entities/grades_response_config.dart';
import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import '../repositories/i_professor_repository.dart';

class GetProfessorGradesUsecase
    implements UseCase<GradesResponseConfig, ParamsGetProfessorGradesUsecase> {
  final IProfessorRepository _repository;

  GetProfessorGradesUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, GradesResponseConfig>> call(params) async {
    return await _repository.getProfessorGrades(
      id: params.id,
    );
  }
}

class ParamsGetProfessorGradesUsecase extends IParams {
  final int id;

  ParamsGetProfessorGradesUsecase({
    required this.id,
  });
}
