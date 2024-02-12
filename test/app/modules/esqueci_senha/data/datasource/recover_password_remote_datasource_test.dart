import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/network/api_url.dart';
import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:app_melivra/app/modules/esqueci_senha/data/datasource/i_recover_password_remote_datasource.dart';
import 'package:app_melivra/app/modules/esqueci_senha/data/datasource/recover_password_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements DioForNative {}

void main() {
  late Dio dio;
  late IRecoverRemoteDatasource datasource;

  const successEmail = "otavio.pontes1103@gmail.com";

  setUp(
    () {
      dio = MockDio();
      datasource = RecoverRemoteDatasource(dio: dio);
    },
  );

  test(
    'should send verification code to email passing email',
    () async {
      when(
        () => dio.post(
          Endpoints.sendValidationCode,
          data: {"email": successEmail},
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: "${Api.prodUrl}${Endpoints.user}",
          ),
          statusCode: 200,
        ),
      );

      final result = await datasource.sendValidationCode(email: successEmail);

      expect(() => result, returnsNormally);
    },
  );

  test(
    'should return ServerException when passing invalid email',
    () async {
      when(
        () => dio.post(any(), data: {"email": ""}),
      ).thenThrow(ServerException());

      expect(
        () => datasource.sendValidationCode(email: ""),
        throwsA(isA<ServerException>()),
      );
    },
  );
}
