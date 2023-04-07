import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/professor_response.dart';
import '../repositories/i_professor_repository.dart';

class GetProfessorsUsecase
    implements UseCase<ProfessorResponse, ParamsGetProfessorsUsecase> {
  final IProfessorRepository _repository;

  GetProfessorsUsecase({
    required IProfessorRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, ProfessorResponse>> call(
    ParamsGetProfessorsUsecase params,
  ) async {
    return _repository.getProfessors(
      instituteId: params.instituteId,
      itemsPerPage: params.itemsPerPage,
      page: params.page,
      searchText: params.searchText,
    );
  }
}

class ParamsGetProfessorsUsecase extends IParams {
  final int? page;
  final int? itemsPerPage;
  final int? instituteId;
  final String? searchText;
  ParamsGetProfessorsUsecase({
    this.page,
    this.itemsPerPage,
    this.instituteId,
    this.searchText,
  });
}
