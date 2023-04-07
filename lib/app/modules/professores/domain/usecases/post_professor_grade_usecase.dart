import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/grade.dart';
import '../repositories/i_professor_repository.dart';

class PostProfessorGradeUsecase
    implements UseCase<void, ParamsPostProfessorGradeUsecase> {
  final IProfessorRepository _repository;

  PostProfessorGradeUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, void>> call(
    ParamsPostProfessorGradeUsecase params,
  ) async {
    return _repository.evaluateProfessor(
      grade: params.grade,
      id: params.id,
    );
  }
}

class ParamsPostProfessorGradeUsecase extends IParams {
  final int id;
  final Grade grade;

  ParamsPostProfessorGradeUsecase({
    required this.id,
    required this.grade,
  });
}
