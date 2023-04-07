import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:app_melivra/app/modules/institutos/domain/repositories/i_instituto_repository.dart';
import 'package:dartz/dartz.dart';

class GetInstitutoDetailsUsecase
    implements UseCase<Instituto, ParamsGetInstitutoDetailsUsecase> {
  final IInstitutoRepository _repository;

  GetInstitutoDetailsUsecase({
    required IInstitutoRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, Instituto>> call(
    ParamsGetInstitutoDetailsUsecase params,
  ) async {
    return _repository.getInstitutoDetails(
      id: params.id,
    );
  }
}

class ParamsGetInstitutoDetailsUsecase extends IParams {
  final int id;

  ParamsGetInstitutoDetailsUsecase({
    required this.id,
  });
}
