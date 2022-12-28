import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import '../entities/professor_entity.dart';
import '../repositories/i_professor_repository.dart';

class GetProfessorDetailsUsecase
    implements UseCase<Professor, ParamsGetProfessorDetailsUsecase> {
  final IProfessorRepository _repository;

  GetProfessorDetailsUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, Professor>> call(params) async {
    return await _repository.getProfessorDetails(
      id: params.id,
    );
  }
}

class ParamsGetProfessorDetailsUsecase extends IParams {
  final int id;

  ParamsGetProfessorDetailsUsecase({
    required this.id,
  });
}
