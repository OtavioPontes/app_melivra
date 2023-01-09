import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/cadastro/data/datasource/i_cadastro_remote_datasource.dart';
import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:app_melivra/app/modules/cadastro/data/services/cadastro_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCadastroDatasource extends Mock implements ICadastroRemoteDatasource {
}

void main() {
  late ICadastroRemoteDatasource datasource;
  late CadastroService service;

  UserCreationModel successUser = UserCreationModel(
    name: 'Otávio',
    email: 'otavio.pontes1103@gmail.com',
    password: '12345',
    passwordConfirmation: '12345',
  );

  UserCreationModel errorUser = UserCreationModel(
    name: 'Otávio',
    email: 'otavio.pontes1103@gmail.com',
    password: '1234',
    passwordConfirmation: '12345',
  );

  UserCreationModel errorEmailUser = UserCreationModel(
    name: 'Otávio',
    email: 'otavio.pontes1103@gmail.com',
    password: '12345',
    passwordConfirmation: '12345',
  );

  setUp(() {
    datasource = MockCadastroDatasource();
    service = CadastroService(cadastroRemoteDatasource: datasource);
  });

  test(
    'should register user',
    () async {
      when((() => datasource.register(user: successUser))).thenAnswer(
        (_) async => voidRight,
      );
      final result = await service.call(user: successUser);

      expect(result, Right(voidRight));
    },
  );

  test(
    'should return ServerFailure when password and password confirmation are different',
    () async {
      when(
        () => datasource.register(user: errorUser),
      ).thenThrow(
        ServerException(message: 'Senhas não batem'),
      );

      final result = await service.call(user: errorUser);

      expect(
        result,
        const Left(
          ServerFailure(message: 'Senhas não batem'),
        ),
      );
      verify(
        () => datasource.register(user: errorUser),
      ).called(1);
    },
  );

  test(
    'should return ServerFailure when email is already at use',
    () async {
      when(
        () => datasource.register(user: errorEmailUser),
      ).thenThrow(
        ServerException(
          message: 'Email já está sendo usando',
        ),
      );

      final result = await service.call(
        user: errorEmailUser,
      );

      expect(
        result,
        const Left(
          ServerFailure(
            message: 'Email já está sendo usando',
          ),
        ),
      );
      verify(
        () => datasource.register(user: errorEmailUser),
      ).called(1);
    },
  );
}
