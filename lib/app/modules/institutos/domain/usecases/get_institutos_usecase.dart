import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:app_melivra/app/modules/institutos/domain/repositories/i_instituto_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import '../entities/institutos_response.dart';

class GetInstitutosUsecase
    implements UseCase<InstitutosResponse, ParamsGetInstitutosUsecase> {
  final IInstitutoRepository _repository;

  GetInstitutosUsecase({
    required IInstitutoRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, InstitutosResponse>> call(params) async {
    return await _repository.getInstitutos(
      params.page,
      params.itemsPerPage,
      params.searchText,
    );
  }
}

class ParamsGetInstitutosUsecase extends IParams {
  final int? page;
  final int? itemsPerPage;
  final String? searchText;
  ParamsGetInstitutosUsecase({
    this.page,
    this.itemsPerPage,
    this.searchText,
  });
}
