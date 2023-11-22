import 'package:app_melivra/app/modules/solicitar_retirada/data/services/send_solicitacao_retirada_service.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/presentation/controllers/solicitar_retirada_controller.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/presentation/pages/solicitar_retirada_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SolicitarRetiradaModule extends Module {
  static const String routeName = '/solicitarRetirada/';
  @override
  List<Bind> get binds => [
        Bind((i) => SendSolicitacaoRetiradaService(dio: i())),
        Bind(
          (i) => SolicitarRetiradaController(
            searchProfessorsBloc: i(),
            getProfessorsUsecase: i(),
            sendSolicitacaoRetiradaService: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const SolicitarRetiradaPage(),
        ),
      ];
}
