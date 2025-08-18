import 'package:app_melivra/app/core/domain/entities/user.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ILoginService {
  Future<Either<IFailure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<IFailure, User>> oauthLogin({
    required String idToken,
  });
}
