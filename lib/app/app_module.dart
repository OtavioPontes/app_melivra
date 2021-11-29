import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:app_melivra/app/modules/splash/domain/usecases/initializers_usecase.dart';
import 'package:app_melivra/app/modules/splash/domain/usecases/splash_pipeline_usecase.dart';
import 'package:app_melivra/app/modules/splash/splash_module.dart';
import 'package:app_melivra/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  static String get initialRoute => SplashModule.initialRoute;

  @override
  List<Bind> get binds => [
        // ------------------------ STORES ------------------------

        // --------------------- CONTROLLERS ----------------------

        // ---------------------- USE CASES -----------------------
        Bind((i) => InitalizersUseCase(networkInfo: i())),

        Bind(
          (i) => SplashPipelineUseCase(
            initalizersUseCase: i(),
            getConfiguracaoUseCase: i(),
            networkInfo: i(),
          ),
        ),

        // --------------------- REPOSITORIES ---------------------

        // --------------------- DATA SOURCES ---------------------

        // ----------------------- SERVICES -----------------------
        Bind((i) => AppInfo.instance),
        Bind<INetworkInfo>((i) => NetworkInfo()),
        Bind<FirebaseCrashlytics>((i) => FirebaseCrashlytics.instance),
        Bind<FirebaseAnalytics>(
          (i) => firebaseAnalytics,
        ),
        // -------------------- NOTIFICATIONS ---------------------
      ];

  @override
  final List<Module> imports = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      SplashModule.initialRoute,
      module: SplashModule(),
    ),
    ModuleRoute(
      InicioModule.initialRoute,
      module: InicioModule(),
    ),
  ];
}
