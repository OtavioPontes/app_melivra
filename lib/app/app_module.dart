import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/bottom_navigation/bottom_navigation_module.dart';
import 'package:app_melivra/app/modules/esqueci_senha/esqueci_senha_module.dart';
import 'package:app_melivra/app/modules/home/home_module.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:app_melivra/app/modules/cadastro/cadastro_module.dart';
import 'package:app_melivra/app/modules/institutos/institutos_module.dart';
import 'package:app_melivra/app/modules/login/login_module.dart';
import 'package:app_melivra/app/modules/perfil/perfil_module.dart';
import 'package:app_melivra/app/modules/professores/professores_module.dart';
import 'package:app_melivra/app/modules/splash/domain/usecases/splash_pipeline_usecase.dart';
import 'package:app_melivra/app/modules/splash/splash_module.dart';
import 'package:app_melivra/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/instituto_details/instituto_details_module.dart';
import 'modules/professores_details/professores_details_module.dart';
import 'modules/ranking_institutos/ranking_institutos_module.dart';

class AppModule extends Module {
  static String get routeName => SplashModule.routeName;

  @override
  List<Bind> get binds => [
        // ------------------------ STORES ------------------------

        // --------------------- CONTROLLERS ----------------------

        // ---------------------- USE CASES -----------------------

        Bind(
          (i) => SplashPipelineUseCase(
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
  final List<ModularRoute> routes = [
    ModuleRoute(
      SplashModule.routeName,
      module: SplashModule(),
    ),
    ModuleRoute(
      InicioModule.routeName,
      module: InicioModule(),
    ),
    ModuleRoute(
      CadastroModule.routeName,
      module: CadastroModule(),
    ),
    ModuleRoute(
      LoginModule.routeName,
      module: LoginModule(),
    ),
    ModuleRoute(
      EsqueciSenhaModule.routeName,
      module: EsqueciSenhaModule(),
    ),
    ModuleRoute(
      BottomNavigationModule.routeName,
      module: BottomNavigationModule(),
    ),
    ModuleRoute(
      HomeModule.routeName,
      module: HomeModule(),
    ),
    ModuleRoute(
      RankingInstitutosModule.routeName,
      module: RankingInstitutosModule(),
    ),
    ModuleRoute(
      ProfessoresModule.routeName,
      module: ProfessoresModule(),
    ),
    ModuleRoute(
      InstitutosModule.routeName,
      module: InstitutosModule(),
    ),
    ModuleRoute(
      PerfilModule.routeName,
      module: PerfilModule(),
    ),
    ModuleRoute(
      InstitutoDetailsModule.routeName,
      module: InstitutoDetailsModule(),
    ),
    ModuleRoute(
      ProfessoresDetailsModule.routeName,
      module: ProfessoresDetailsModule(),
    ),
  ];
}
