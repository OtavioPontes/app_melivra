import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/update_password_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRecoverPasswordRepository extends Mock
    implements IRecoverPasswordRepository {}

void main() {
  late UpdatePasswordUsecase usecase;
  late IRecoverPasswordRepository repository;

  const successEmail = "otavio.pontes1103@gmail.com";
  const validationCode = "12345678";
  const password = "reallystrongpassword";
  const passwordConfirmation = "reallystrongpassword";

  setUp(
    () {
      repository = MockRecoverPasswordRepository();
      usecase = UpdatePasswordUsecase(repository: repository);
    },
  );

  test(
    'should register new user',
    () async {
      when(
        () => repository.updatePassword(
          email: successEmail,
          code: validationCode,
          password: password,
          passwordConfirm: passwordConfirmation,
        ),
      ).thenAnswer(
        (_) async => Right<IFailure, void>(voidRight),
      );

      final result = await usecase.call(
        ParamsUpdatePasswordUsecase(
          email: successEmail,
          code: validationCode,
          password: password,
          passwordConfirm: passwordConfirmation,
        ),
      );

      expect(result, Right(voidRight));
      verify(
        () => repository.updatePassword(
          email: successEmail,
          code: validationCode,
          password: password,
          passwordConfirm: passwordConfirmation,
        ),
      ).called(1);
    },
  );

  test(
    'should return ServerFailure when params are invalid',
    () async {
      when(
        () => repository.updatePassword(
          email: "",
          code: "",
          password: "",
          passwordConfirm: "",
        ),
      ).thenAnswer(
        (_) async => const Left<IFailure, void>(
          ServerFailure(message: 'Não foi possível atualizar a senha'),
        ),
      );

      final result = await usecase.call(
        ParamsUpdatePasswordUsecase(
          email: "",
          code: "",
          password: "",
          passwordConfirm: "",
        ),
      );

      expect(
        result,
        const Left(
          ServerFailure(message: 'Não foi possível atualizar a senha'),
        ),
      );
      verify(
        () => repository.updatePassword(
          email: "",
          code: "",
          password: "",
          passwordConfirm: "",
        ),
      ).called(1);
    },
  );
}
