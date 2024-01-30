import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/validate_recover_code_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRecoverPasswordRepository extends Mock
    implements IRecoverPasswordRepository {}

void main() {
  late ValidateRecoverCodeUsecase usecase;
  late IRecoverPasswordRepository repository;

  const successEmail = "otavio.pontes1103@gmail.com";
  const validationCode = "12345678";

  setUp(
    () {
      repository = MockRecoverPasswordRepository();
      usecase = ValidateRecoverCodeUsecase(repository: repository);
    },
  );

  test(
    'should validate the recover code',
    () async {
      when(
        () => repository.validateCode(
          email: successEmail,
          code: validationCode,
        ),
      ).thenAnswer(
        (_) async => Right<IFailure, void>(voidRight),
      );

      final result = await usecase.call(
        ParamsValidateRecoverCodeUsecase(
          email: successEmail,
          code: validationCode,
        ),
      );

      expect(result, Right(voidRight));
      verify(
        () => repository.validateCode(
          email: successEmail,
          code: validationCode,
        ),
      ).called(1);
    },
  );

  test(
    'should return ServerFailure when params are invalid',
    () async {
      when(
        () => repository.validateCode(
          email: "",
          code: "",
        ),
      ).thenAnswer(
        (_) async => const Left<IFailure, void>(
          ServerFailure(message: 'Não foi possível validar o código'),
        ),
      );

      final result = await usecase.call(
        ParamsValidateRecoverCodeUsecase(
          email: "",
          code: "",
        ),
      );

      expect(
        result,
        const Left(
          ServerFailure(message: 'Não foi possível validar o código'),
        ),
      );
      verify(
        () => repository.validateCode(
          email: "",
          code: "",
        ),
      ).called(1);
    },
  );
}
