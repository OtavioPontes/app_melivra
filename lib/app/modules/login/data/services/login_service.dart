import 'package:app_melivra/app/modules/login/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/domain/entities/user.dart';
import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/login/data/datasources/i_login_datasource.dart';
import 'package:app_melivra/app/modules/login/domain/services/i_login_service.dart';

class LoginService implements ILoginService {
  final ILoginDatasource _loginDatasource;
  LoginService({
    required ILoginDatasource loginDatasource,
  }) : _loginDatasource = loginDatasource;
  @override
  Future<Either<IFailure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserModel model = await _loginDatasource.login(
        email: email,
        password: password,
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    }
  }
}
