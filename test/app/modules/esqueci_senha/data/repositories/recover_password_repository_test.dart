import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/error/failures.dart';

import 'package:app_melivra/app/modules/esqueci_senha/data/datasource/i_recover_password_remote_datasource.dart';
import 'package:app_melivra/app/modules/esqueci_senha/data/repositories/recover_password_repository.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRecoverPasswordDatasource extends Mock
    implements IRecoverRemoteDatasource {}

void main() {
  late IRecoverRemoteDatasource datasource;
  late IRecoverPasswordRepository repository;

  setUp(() {
    datasource = MockRecoverPasswordDatasource();
    repository = RecoverPasswordRepository(datasource: datasource);
  });

  const successEmail = "otavio.pontes1103@gmail.com";

  test(
    'should send validation code',
    () async {
      when(() => datasource.sendValidationCode(email: successEmail)).thenAnswer(
        (_) async => voidRight,
      );
      final result = await repository.sendValidationCode(email: successEmail);

      expect(result, Right(voidRight));
    },
  );

  test(
    'should return ServerFailure when email is invalid',
    () async {
      when(
        () => datasource.sendValidationCode(email: successEmail),
      ).thenThrow(
        ServerException(message: 'Email incorreto'),
      );

      final result = await repository.sendValidationCode(email: successEmail);

      expect(
        result,
        const Left(
          ServerFailure(message: 'Email incorreto'),
        ),
      );
      verify(
        () => datasource.sendValidationCode(email: successEmail),
      ).called(1);
    },
  );
}
