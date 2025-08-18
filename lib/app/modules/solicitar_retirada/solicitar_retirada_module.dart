import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/data/services/send_solicitacao_retirada_service.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/domain/services/i_send_solicitacao_retirada_service.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/presentation/controllers/solicitar_retirada_controller.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/presentation/pages/solicitar_retirada_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SolicitarRetiradaModule extends Module {
  static const String routeName = '/solicitarRetirada/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<ISendSolicitacaoRetiradaService>(
      () => SendSolicitacaoRetiradaService(dio: i()),
    );
    i.add(
      () => SolicitarRetiradaController(
        searchProfessorsBloc: i(),
        getProfessorsUsecase: i(),
        sendSolicitacaoRetiradaService: i(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const SolicitarRetiradaPage(),
    );
  }
}
