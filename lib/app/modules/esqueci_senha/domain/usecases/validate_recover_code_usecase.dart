import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:dartz/dartz.dart';

class ValidateRecoverCodeUsecase
    extends UseCase<void, ParamsValidateRecoverCodeUsecase> {
  final IRecoverPasswordRepository _repository;
  ValidateRecoverCodeUsecase({
    required IRecoverPasswordRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, dynamic>> call(
    ParamsValidateRecoverCodeUsecase params,
  ) async {
    return _repository.validateCode(code: params.code);
  }
}

class ParamsValidateRecoverCodeUsecase {
  final String code;
  ParamsValidateRecoverCodeUsecase({required this.code});
}
