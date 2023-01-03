import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import '../repositories/i_professor_repository.dart';

class UpdateProfessorGradeUsecase
    implements UseCase<void, ParamsUpdateProfessorGradeUsecase> {
  final IProfessorRepository _repository;

  UpdateProfessorGradeUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, void>> call(params) async {
    return await _repository.updateProfessorGrade(
        id: params.id, description: params.description);
  }
}

class ParamsUpdateProfessorGradeUsecase extends IParams {
  final int id;
  final String description;

  ParamsUpdateProfessorGradeUsecase({
    required this.id,
    required this.description,
  });
}
