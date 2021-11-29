import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/inicio/presentation/pages/inicio_page.dart';
import 'package:app_melivra/app/modules/splash/presentation/controller/splash_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/controller/inicio_controller.dart';

class InicioModule extends Module {
  static const String routeName = '/inicio';
  static const String initialRoute = '/inicio/';

  @override
  List<Bind> get binds => [
        // ------------------------ STORES ------------------------

        // --------------------- CONTROLLERS ----------------------
        Bind(
          (i) => InicioController(),
        ),

        // ---------------------- USE CASES -----------------------

        // --------------------- REPOSITORIES ---------------------

        // --------------------- DATA SOURCES ---------------------

        // ----------------------- SERVICES -----------------------

        // -------------------- NOTIFICATIONS ---------------------
      ];

  @override
  final List<Module> imports = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const InicioPage(),
    ),
  ];
}
