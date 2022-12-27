import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/login/domain/services/i_login_service.dart';

import '../../../../core/domain/entities/user.dart';

class LoginUsecase implements UseCase<User, ParamsLoginUsecase> {
  final ILoginService _service;
  LoginUsecase({
    required ILoginService service,
  }) : _service = service;
  @override
  Future<Either<IFailure, User>> call(params) async {
    try {
      return await _service.login(
        email: params.email,
        password: params.password,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class ParamsLoginUsecase extends IParams {
  final String email;
  final String password;
  ParamsLoginUsecase({
    required this.email,
    required this.password,
  });
}
