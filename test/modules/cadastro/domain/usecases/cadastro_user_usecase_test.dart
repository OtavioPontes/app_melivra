import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:app_melivra/app/modules/cadastro/domain/services/i_cadastro_service.dart';
import 'package:app_melivra/app/modules/cadastro/domain/usecases/cadastro_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCadastroService extends Mock implements ICadastroService {}

void main() {
  late CadastroUserUsecase usecase;
  late ICadastroService service;

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

  setUp(
    () {
      service = MockCadastroService();
      usecase = CadastroUserUsecase(service: service);
    },
  );

  test(
    'should register new user',
    () async {
      when(
        () => service.call(user: successUser),
      ).thenAnswer(
        (_) async => Right<IFailure, void>(voidRight),
      );

      final result = await usecase.call(
        ParamsCadastroUserUsecase(user: successUser),
      );

      expect(result, Right(voidRight));
      verify(() => service.call(user: successUser)).called(1);
    },
  );

  test(
    'should return ServerFailure when password and password confirmation are different',
    () async {
      when(
        () => service.call(user: errorUser),
      ).thenAnswer(
        (_) async => const Left<IFailure, void>(
          ServerFailure(message: 'Senhas não batem'),
        ),
      );

      final result = await usecase.call(
        ParamsCadastroUserUsecase(user: errorUser),
      );

      expect(
        result,
        const Left(
          ServerFailure(message: 'Senhas não batem'),
        ),
      );
      verify(
        () => service.call(user: errorUser),
      ).called(1);
    },
  );

  test(
    'should return ServerFailure when email is already at use',
    () async {
      when(
        () => service.call(user: errorEmailUser),
      ).thenAnswer(
        (_) async => const Left<IFailure, void>(
          ServerFailure(message: 'Email já está sendo usando'),
        ),
      );

      final result = await usecase.call(
        ParamsCadastroUserUsecase(user: errorEmailUser),
      );

      expect(
        result,
        const Left(
          ServerFailure(message: 'Email já está sendo usando'),
        ),
      );
      verify(
        () => service.call(user: errorEmailUser),
      ).called(1);
    },
  );
}
