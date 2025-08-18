import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/professores/presentation/pages/professores_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfessoresModule extends Module {
  static const String routeName = '/professores/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => ProfessoresPage(),
    );
  }
}
