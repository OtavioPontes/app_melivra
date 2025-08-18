import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/meu_perfil/data/datasource/i_perfil_datasource.dart';
import 'package:app_melivra/app/modules/meu_perfil/data/datasource/perfil_datasource.dart';
import 'package:app_melivra/app/modules/meu_perfil/data/repository/perfil_repository.dart';
import 'package:app_melivra/app/modules/meu_perfil/domain/repository/i_perfil_repository.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/bloc/meu_perfil_bloc.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/controllers/meu_perfil_controller.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/pages/meu_perfil_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeuPerfilModule extends Module {
  static const String routeName = '/meuPerfil/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<IPerfilRepository>(
      () => PerfilRepository(perfilRemoteDatasource: i()),
    );
    i.add<IPerfilDatasource>(() => PerfilDatasource(dio: i()));
    i.add(MeuPerfilBloc.new);
    i.add(() => MeuPerfilController(repository: i(), bloc: i(), store: i()));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => MeuPerfilPage(),
    );
  }
}
