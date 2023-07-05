import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/network/api_url.dart';
import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:app_melivra/app/modules/cadastro/data/datasource/cadastro_remote_datasource.dart';
import 'package:app_melivra/app/modules/cadastro/data/datasource/i_cadastro_remote_datasource.dart';
import 'package:app_melivra/app/modules/cadastro/data/models/user_creation_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements DioForNative {}

void main() {
  late Dio dio;
  late ICadastroRemoteDatasource datasource;

  final successUser = UserCreationModel(
    name: 'Otávio',
    email: 'otavio.pontes1103@gmail.com',
    password: '12345',
    passwordConfirmation: '12345',
  );

  final errorUser = UserCreationModel(
    name: 'Otávio',
    email: 'otavio.pontes1103@gmail.com',
    password: '1234',
    passwordConfirmation: '12345',
  );

  final errorEmailUser = UserCreationModel(
    name: 'Otávio',
    email: 'otavio.pontes1103@gmail.com',
    password: '12345',
    passwordConfirmation: '12345',
  );

  setUp(
    () {
      dio = MockDio();
      datasource = CadastroRemoteDatasource(dio: dio);
    },
  );

  test(
    'should register user',
    () async {
      when(
        () => dio.post(Endpoints.createUser, data: successUser.toMap()),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: "${Api.prodUrl}${Endpoints.createUser}",
          ),
          statusCode: 200,
        ),
      );

      final result = await datasource.register(user: successUser);

      expect(() => result, returnsNormally);
    },
  );

  test(
    'should return ServerException when password and password confirmation are different',
    () async {
      when(
        () => dio.post(any(), data: errorUser.toMap()),
      ).thenThrow(ServerException());

      expect(
        () => datasource.register(user: errorUser),
        throwsA(isA<ServerException>()),
      );
    },
  );

  test(
    'should return ServerFailure when email is already at use',
    () async {
      when(
        () => dio.post(any(), data: errorEmailUser.toMap()),
      ).thenThrow(ServerException());

      expect(
        () => datasource.register(user: errorEmailUser),
        throwsA(isA<ServerException>()),
      );
    },
  );
}
