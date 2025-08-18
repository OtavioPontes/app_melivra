import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/inicio/presentation/pages/inicio_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/controller/inicio_controller.dart';

class InicioModule extends Module {
  static const String routeName = '/inicio/';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add(() => InicioController(loginService: i(), userStore: i()));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const InicioPage(),
    );
  }
}
