import 'package:app_melivra/app/core/bloc/user_bloc.dart';
import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/about_us/about_us_module.dart';
import 'package:app_melivra/app/modules/bottom_navigation/bottom_navigation_module.dart';
import 'package:app_melivra/app/modules/esqueci_senha/esqueci_senha_module.dart';
import 'package:app_melivra/app/modules/home/home_module.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/ultimos_pesquisados_bloc.dart';
import 'package:app_melivra/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:app_melivra/app/modules/cadastro/cadastro_module.dart';
import 'package:app_melivra/app/modules/institutos/institutos_module.dart';
import 'package:app_melivra/app/modules/login/login_module.dart';
import 'package:app_melivra/app/modules/meu_perfil/meu_perfil_module.dart';
import 'package:app_melivra/app/modules/perfil/perfil_module.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/post_professor_grade_usecase.dart';
import 'package:app_melivra/app/modules/professores/professores_module.dart';
import 'package:app_melivra/app/modules/sobre_app/sobre_app_module.dart';
import 'package:app_melivra/app/modules/splash/domain/usecases/splash_pipeline_usecase.dart';
import 'package:app_melivra/app/modules/splash/splash_module.dart';
import 'package:app_melivra/app/modules/suggestions/suggestions_module.dart';
import 'package:app_melivra/main.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/dio_config.dart';
import 'modules/home/presentation/bloc/top_institutos_bloc.dart';
import 'modules/instituto_details/instituto_details_module.dart';
import 'modules/institutos/data/datasources/i_instituto_datasource.dart';
import 'modules/institutos/data/datasources/instituto_datasource.dart';
import 'modules/institutos/data/repositories/instituto_repository.dart';
import 'modules/institutos/domain/repositories/i_instituto_repository.dart';
import 'modules/institutos/domain/usecases/get_instituto_details.dart';
import 'modules/institutos/domain/usecases/get_institutos_rank_usecase.dart';
import 'modules/institutos/domain/usecases/get_institutos_usecase.dart';
import 'modules/institutos/presentation/bloc/institutos_bloc.dart';
import 'modules/institutos/presentation/controllers/institutos_controller.dart';
import 'modules/perfil/presentation/controllers/perfil_controller.dart';
import 'modules/professores/data/datasources/i_professor_datasource.dart';
import 'modules/professores/data/datasources/professors_datasource.dart';
import 'modules/professores/data/repositories/professor_repository.dart';
import 'modules/professores/domain/repositories/i_professor_repository.dart';
import 'modules/professores/domain/usecases/get_professor_details_usecase.dart';
import 'modules/professores/domain/usecases/get_professor_grades_usecase.dart';
import 'modules/professores/domain/usecases/get_professors_rank_usecase.dart';
import 'modules/professores/domain/usecases/get_professors_usecase.dart';
import 'modules/professores/domain/usecases/update_professor_grade_usecase.dart';
import 'modules/professores/presentation/bloc/professors_bloc.dart';
import 'modules/professores/presentation/controllers/professores_controller.dart';
import 'modules/professores_details/professores_details_module.dart';
import 'modules/ranking_institutos/ranking_institutos_module.dart';
import 'modules/search/search_module.dart';

class AppModule extends Module {
  static String get routeName => SplashModule.routeName;

  @override
  List<Bind> get binds => [
        // ------------------------ STORES ------------------------
        Bind((i) => UserStore(bloc: i(), hiveBox: i())),
        Bind((i) => TopInstitutosBloc()),
        Bind((i) => UltimosPesquisadosBloc()),
        Bind((i) => UserBloc()),
        Bind(
          (i) => HomeController(
            store: i(),
            getProfessorDetailsUsecase: i(),
            getInstitutosRankUsecase: i(),
            topInstitutosBloc: i(),
            ultimosPesquisadosBloc: i(),
            box: i(),
          ),
        ),
        Bind((i) => PerfilController(store: i())),
        Bind((i) => InstitutosBloc()),
        Bind(
          (i) => InstitutosController(
            getInstitutosUsecase: i(),
            bloc: i(),
          ),
        ),
        Bind((i) => ProfessorsBloc()),
        Bind(
          (i) => ProfessorsController(
            getProfessorsUsecase: i(),
            bloc: i(),
          ),
        ),

        // --------------------- CONTROLLERS ----------------------

        // ---------------------- USE CASES -----------------------

        Bind((i) => GetInstitutoDetailsUsecase(repository: i())),
        Bind((i) => GetInstitutosRankUsecase(repository: i())),
        Bind((i) => GetInstitutosUsecase(repository: i())),

        Bind((i) => GetProfessorDetailsUsecase(repository: i())),
        Bind((i) => GetProfessorsRankUsecase(repository: i())),
        Bind((i) => GetProfessorsUsecase(repository: i())),
        Bind((i) => PostProfessorGradeUsecase(repository: i())),
        Bind((i) => UpdateProfessorGradeUsecase(repository: i())),
        Bind((i) => GetProfessorGradesUsecase(repository: i())),

        Bind(
          (i) => SplashPipelineUseCase(
            dioConfig: i(),
            store: i(),
            networkInfo: i(),
          ),
        ),

        // --------------------- REPOSITORIES ---------------------
        Bind<IInstitutoRepository>((i) => InstitutoRepository(datasource: i())),
        Bind<IProfessorRepository>((i) => ProfessorRepository(datasource: i())),

        // --------------------- DATA SOURCES ---------------------
        Bind<IInstitutoDatasource>((i) => InstitutoDatasource(dio: i())),
        Bind<IProfessorDatasource>((i) => ProfessorsDatasource(dio: i())),

        // ----------------------- SERVICES -----------------------
        Bind((i) => AppInfo.instance),
        Bind<INetworkInfo>((i) => NetworkInfo()),
        Bind<FirebaseCrashlytics>((i) => FirebaseCrashlytics.instance),
        Bind<FirebaseAnalytics>(
          (i) => firebaseAnalytics,
        ),
        Bind(
          (i) => Dio(),
        ),
        Bind(
          (i) => DioConfig(
            dio: i(),
          ),
        ),

        Bind<Box>((i) => Hive.box('melivra'))

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
      HomeModule.routeName,
      module: HomeModule(),
    ),
    ModuleRoute(
      BottomNavigationModule.routeName,
      module: BottomNavigationModule(),
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
    ModuleRoute(
      SearchModule.routeName,
      module: SearchModule(),
    ),
    ModuleRoute(
      MeuPerfilModule.routeName,
      module: MeuPerfilModule(),
    ),
    ModuleRoute(
      SobreAppModule.routeName,
      module: SobreAppModule(),
    ),
    ModuleRoute(
      SuggestionModule.routeName,
      module: SuggestionModule(),
    ),
    ModuleRoute(
      AboutUsModule.routeName,
      module: AboutUsModule(),
    ),
  ];
}
