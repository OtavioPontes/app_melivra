import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/cadastro/data/datasource/cadastro_remote_datasource.dart';
import 'package:app_melivra/app/modules/cadastro/data/datasource/i_cadastro_remote_datasource.dart';
import 'package:app_melivra/app/modules/cadastro/data/services/cadastro_service.dart';
import 'package:app_melivra/app/modules/cadastro/domain/services/i_cadastro_service.dart';
import 'package:app_melivra/app/modules/cadastro/domain/usecases/cadastro_user_usecase.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/controllers/cadastro_controller.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/controllers/validate_email_controller.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/pages/cadastro_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroModule extends Module {
  static const String routeName = '/cadastro/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add(CadastroBloc.new);
    i.add<ICadastroRemoteDatasource>(
      () => CadastroRemoteDatasource(dio: i()),
    );
    i.add<ICadastroService>(
      () => CadastroService(cadastroRemoteDatasource: i()),
    );
    i.add(() => CadastroUserUsecase(service: i()));
    i.add(() => CadastroController(cadastroUserUsecase: i(), bloc: i()));
    i.add(() => ValidateEmailController(cadastroService: i()));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const CadastroPage(),
    );
  }
}
