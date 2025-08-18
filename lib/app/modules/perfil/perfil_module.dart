import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/perfil/presentation/pages/perfil_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfilModule extends Module {
  static const String routeName = '/perfil/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => PerfilPage(),
    );
  }
}
