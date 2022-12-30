import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import '../../../../core/domain/entities/grade.dart';
import '../repositories/i_professor_repository.dart';

class PostProfessorGradeUsecase
    implements UseCase<void, ParamsPostProfessorGradeUsecase> {
  final IProfessorRepository _repository;

  PostProfessorGradeUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, void>> call(params) async {
    return await _repository.evaluateProfessor(
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
