import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import '../repositories/i_professor_repository.dart';

class GetGlobalGradeUsecase implements UseCase<Grade, NoParams> {
  final IProfessorRepository _repository;

  GetGlobalGradeUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, Grade>> call(params) async {
    return await _repository.getGlobalGrades();
  }
}
