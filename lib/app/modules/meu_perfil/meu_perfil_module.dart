import 'package:app_melivra/app/modules/meu_perfil/data/datasource/update_perfil_datasource.dart';
import 'package:app_melivra/app/modules/meu_perfil/data/services/update_perfil_service.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/bloc/meu_perfil_bloc.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/controllers/meu_perfil_controller.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/pages/meu_perfil_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeuPerfilModule extends Module {
  static const routeName = "/meuPerfil/";
  @override
  List<Bind> get binds => [
        Bind(
          (i) => UpdatePerfilService(updatePerfilRemoteDatasource: i()),
        ),
        Bind(
          (i) => UpdatePerfilDatasource(dio: i()),
        ),
        Bind(
          (i) => MeuPerfilBloc(),
        ),
        Bind(
          (i) => MeuPerfilController(
            updatePerfilService: i(),
            bloc: i(),
            store: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => MeuPerfilPage(),
        )
      ];
}
