import 'package:app_melivra/app/modules/cadastro/data/datasource/cadastro_remote_datasource.dart';
import 'package:app_melivra/app/modules/cadastro/data/services/cadastro_service.dart';
import 'package:app_melivra/app/modules/cadastro/domain/usecases/cadastro_user_usecase.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/controllers/cadastro_controller.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/pages/cadastro_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroModule extends Module {
  static String routeName = '/cadastro/';

  @override
  List<Bind> get binds => [
        Bind((i) => CadastroBloc()),
        Bind((i) => CadastroRemoteDatasource(dio: i())),
        Bind((i) => CadastroService(cadastroRemoteDatasource: i())),
        Bind((i) => CadastroUserUsecase(service: i())),
        Bind((i) => CadastroController(cadastroUserUsecase: i(), bloc: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const CadastroPage(),
        )
      ];
}
