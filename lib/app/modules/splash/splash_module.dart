import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/splash/domain/usecases/get_configuracao_usecase.dart';
import 'package:app_melivra/app/modules/splash/presentation/controller/splash_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/splash_page.dart';

class SplashModule extends Module {
  static const String routeName = '/splash';
  static const String initialRoute = '/splash/';

  @override
  List<Bind> get binds => [
        // ------------------------ STORES ------------------------

        // --------------------- CONTROLLERS ----------------------
        Bind(
          (i) => SplashController(
            appInfo: AppInfo.instance,
            pipeline: i(),
          ),
        ),

        // ---------------------- USE CASES -----------------------
        Bind((i) => GetConfiguracaoUseCase()),

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
      child: (_, args) => const SplashPage(),
    ),
  ];
}
