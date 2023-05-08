import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/send_recover_code_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/validate_recover_code_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasource/recover_password_remote_datasource.dart';
import 'data/repositories/recover_password_repository.dart';
import 'presentation/esqueci_senha_page.dart';

class EsqueciSenhaModule extends Module {
  static String routeName = '/esqueciSenha/';
  @override
  List<Bind> get binds => [
        Bind((i) => RecoverRemoteDatasource(dio: i())),
        Bind((i) => RecoverPasswordRepository(datasource: i())),
        Bind((i) => SendRecoverCodeUsecase(repository: i())),
        Bind((i) => ValidateRecoverCodeUsecase(repository: i())),
        Bind(
          (i) => RecoverPasswordController(
            sendRecoverCodeUsecase: i(),
            validateRecoverCodeUsecase: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const EsqueciSenhaPage(),
        )
      ];
}
