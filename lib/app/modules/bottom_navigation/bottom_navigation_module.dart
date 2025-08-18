import 'package:app_melivra/app/core/core_module.dart';

import 'package:app_melivra/app/modules/bottom_navigation/presentation/pages/bottom_navigation_page.dart';
import 'package:app_melivra/app/modules/home/home_module.dart';
import 'package:app_melivra/app/modules/institutos/institutos_module.dart';
import 'package:app_melivra/app/modules/perfil/perfil_module.dart';
import 'package:app_melivra/app/modules/professores/professores_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomNavigationModule extends Module {
  static const String routeName = '/bottomNavigation';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const BottomNavigationPage(),
      children: [
        ModuleRoute(HomeModule.routeName, module: HomeModule()),
        ModuleRoute(
          ProfessoresModule.routeName,
          module: ProfessoresModule(),
        ),
        ModuleRoute(
          InstitutosModule.routeName,
          module: InstitutosModule(),
        ),
        ModuleRoute(PerfilModule.routeName, module: PerfilModule()),
      ],
    );
  }
}
