import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/i_professor_repository.dart';

class GetProfessorGradeByUserUsecase
    implements UseCase<Grade?, ParamsGetProfessorGradeByUserUsecase> {
  final IProfessorRepository _repository;

  GetProfessorGradeByUserUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, Grade?>> call(
    ParamsGetProfessorGradeByUserUsecase params,
  ) async {
    return _repository.getProfessorGradesByUser(
      id: params.id,
    );
  }
}

class ParamsGetProfessorGradeByUserUsecase extends IParams {
  final int id;

  ParamsGetProfessorGradeByUserUsecase({
    required this.id,
  });
}
