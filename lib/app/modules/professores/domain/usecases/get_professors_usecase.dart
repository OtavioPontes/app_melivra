import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import '../entities/professor_response.dart';
import '../repositories/i_professor_repository.dart';

class GetProfessorsUsecase
    implements UseCase<ProfessorResponse, ParamsGetProfessorsUsecase> {
  final IProfessorRepository _repository;

  GetProfessorsUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, ProfessorResponse>> call(params) async {
    return await _repository.getProfessors(
      params.page,
      params.itemsPerPage,
      params.searchText,
    );
  }
}

class ParamsGetProfessorsUsecase extends IParams {
  final int? page;
  final int? itemsPerPage;
  final String? searchText;
  ParamsGetProfessorsUsecase({
    this.page,
    this.itemsPerPage,
    this.searchText,
  });
}
