import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePasswordUsecase extends UseCase<void, ParamsUpdatePasswordUsecase> {
  final IRecoverPasswordRepository _repository;
  UpdatePasswordUsecase({
    required IRecoverPasswordRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<IFailure, dynamic>> call(
    ParamsUpdatePasswordUsecase params,
  ) async {
    return _repository.updatePassword(
      code: params.code,
      email: params.email,
      password: params.password,
      passwordConfirm: params.passwordConfirm,
    );
  }
}

class ParamsUpdatePasswordUsecase {
  final String code;
  final String email;
  final String password;
  final String passwordConfirm;
  ParamsUpdatePasswordUsecase({
    required this.code,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });
}
