import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:dartz/dartz.dart';

class SendRecoverCodeUsecase
    extends UseCase<void, ParamsSendRecoverCodeUsecase> {
  final IRecoverPasswordRepository _repository;
  SendRecoverCodeUsecase({
    required IRecoverPasswordRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, dynamic>> call(
    ParamsSendRecoverCodeUsecase params,
  ) async {
    return _repository.sendValidationCode(email: params.email);
  }
}

class ParamsSendRecoverCodeUsecase {
  final String email;
  ParamsSendRecoverCodeUsecase({required this.email});
}
