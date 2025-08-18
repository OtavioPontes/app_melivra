import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/esqueci_senha/data/datasource/i_recover_password_remote_datasource.dart';
import 'package:app_melivra/app/modules/esqueci_senha/data/datasource/recover_password_remote_datasource.dart';
import 'package:app_melivra/app/modules/esqueci_senha/data/repositories/recover_password_repository.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/repository/i_recover_password_repository.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/send_recover_code_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/update_password_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/domain/usecases/validate_recover_code_usecase.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/esqueci_senha_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EsqueciSenhaModule extends Module {
  static const String routeName = '/esqueciSenha/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<IRecoverRemoteDatasource>(() => RecoverRemoteDatasource(dio: i()));
    i.add<IRecoverPasswordRepository>(
      () => RecoverPasswordRepository(datasource: i()),
    );
    i.add(() => SendRecoverCodeUsecase(repository: i()));
    i.add(() => ValidateRecoverCodeUsecase(repository: i()));
    i.add(() => UpdatePasswordUsecase(repository: i()));
    i.add(
      () => RecoverPasswordController(
        updatePasswordUsecase: i(),
        sendRecoverCodeUsecase: i(),
        validateRecoverCodeUsecase: i(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const EsqueciSenhaPage(),
    );
  }
}
