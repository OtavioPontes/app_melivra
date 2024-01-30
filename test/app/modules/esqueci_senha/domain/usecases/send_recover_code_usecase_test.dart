import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/send_recover_code_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRecoverPasswordRepository extends Mock
    implements IRecoverPasswordRepository {}

void main() {
  late SendRecoverCodeUsecase usecase;
  late IRecoverPasswordRepository repository;

  const successEmail = "otavio.pontes1103@gmail.com";

  setUp(
    () {
      repository = MockRecoverPasswordRepository();
      usecase = SendRecoverCodeUsecase(repository: repository);
    },
  );

  test(
    'should send validation code',
    () async {
      when(
        () => repository.sendValidationCode(email: successEmail),
      ).thenAnswer(
        (_) async => Right<IFailure, void>(voidRight),
      );

      final result = await usecase.call(
        ParamsSendRecoverCodeUsecase(email: successEmail),
      );

      expect(result, Right(voidRight));
      verify(() => repository.sendValidationCode(email: successEmail))
          .called(1);
    },
  );

  test(
    'should return ServerFailure when email is invalid',
    () async {
      when(
        () => repository.sendValidationCode(email: ""),
      ).thenAnswer(
        (_) async => const Left<IFailure, void>(
          ServerFailure(message: 'Email inválido'),
        ),
      );

      final result = await usecase.call(
        ParamsSendRecoverCodeUsecase(email: ""),
      );

      expect(
        result,
        const Left(
          ServerFailure(message: 'Email inválido'),
        ),
      );
      verify(
        () => repository.sendValidationCode(email: ""),
      ).called(1);
    },
  );
}
