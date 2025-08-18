// ignore_for_file: unnecessary_lambdas

import 'package:app_melivra/app/core/bloc/user_bloc.dart';
import 'package:app_melivra/app/core/network/dio_config.dart';
import 'package:app_melivra/app/core/network/network_info.dart';
import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/top_institutos_bloc.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/ultimos_pesquisados_bloc.dart';
import 'package:app_melivra/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:app_melivra/app/modules/institutos/data/datasources/i_instituto_datasource.dart';
import 'package:app_melivra/app/modules/institutos/data/datasources/instituto_datasource.dart';
import 'package:app_melivra/app/modules/institutos/data/repositories/instituto_repository.dart';
import 'package:app_melivra/app/modules/institutos/domain/repositories/i_instituto_repository.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_instituto_details.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_rank_usecase.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_usecase.dart';
import 'package:app_melivra/app/modules/institutos/presentation/bloc/institutos_bloc.dart';
import 'package:app_melivra/app/modules/institutos/presentation/controllers/institutos_controller.dart';
import 'package:app_melivra/app/modules/login/data/datasources/i_login_datasource.dart';
import 'package:app_melivra/app/modules/login/data/datasources/login_datasource.dart';
import 'package:app_melivra/app/modules/login/data/services/login_service.dart';
import 'package:app_melivra/app/modules/login/domain/services/i_login_service.dart';
import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';
import 'package:app_melivra/app/modules/professores/data/datasources/i_professor_datasource.dart';
import 'package:app_melivra/app/modules/professores/data/datasources/professors_datasource.dart';
import 'package:app_melivra/app/modules/professores/data/repositories/professor_repository.dart';
import 'package:app_melivra/app/modules/professores/domain/repositories/i_professor_repository.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_global_grade_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professor_details_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professor_grade_by_user_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professor_grades_count_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professor_grades_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_rank_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/post_professor_grade_like_dislike_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/post_professor_grade_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/update_professor_grade_usecase.dart';
import 'package:app_melivra/app/modules/professores/presentation/bloc/global_grade_bloc.dart';
import 'package:app_melivra/app/modules/professores/presentation/bloc/professors_bloc.dart';
import 'package:app_melivra/app/modules/professores/presentation/controllers/professores_controller.dart';
import 'package:app_melivra/app/modules/search/presentation/bloc/search_institutes_bloc.dart';
import 'package:app_melivra/app/modules/search/presentation/bloc/search_professor_bloc.dart';
import 'package:app_melivra/app/modules/splash/domain/usecases/splash_pipeline_usecase.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

class CoreModule extends Module {
  static late String url;

  @override
  void exportedBinds(Injector i) {
    i.addSingleton(() => UserStore(bloc: i(), hiveBox: i()));
    i.add(() => TopInstitutosBloc());
    i.add(() => UltimosPesquisadosBloc());
    i.add(() => UserBloc());
    i.add(() => GlobalGradeBloc());
    i.add(() => SearchProfessorsBloc());
    i.add(() => SearchInstitutesBloc());
    i.add(
      () => HomeController(
        store: i(),
        getProfessorDetailsUsecase: i(),
        getInstitutosRankUsecase: i(),
        topInstitutosBloc: i(),
        ultimosPesquisadosBloc: i(),
        box: i(),
      ),
    );
    i.add(() => PerfilController(store: i()));
    i.add(() => InstitutosBloc());
    i.add(
      () => InstitutosController(
        getGlobalGradeUsecase: i(),
        globalGradeBloc: i(),
        getInstitutosUsecase: i(),
        bloc: i(),
      ),
    );
    i.add(() => ProfessorsBloc());
    i.add(
      () => ProfessorsController(
        getGlobalGradeUsecase: i(),
        getProfessorsUsecase: i(),
        globalGradeBloc: i(),
        bloc: i(),
      ),
    );

    // --------------------- CONTROLLERS ----------------------

    // ---------------------- USE CASES -----------------------

    i.add(() => GetInstitutoDetailsUsecase(repository: i()));
    i.add(() => GetInstitutosRankUsecase(repository: i()));
    i.add(() => GetInstitutosUsecase(repository: i()));

    i.add(() => GetProfessorDetailsUsecase(repository: i()));
    i.add(() => GetProfessorsRankUsecase(repository: i()));
    i.add(() => GetProfessorsUsecase(repository: i()));
    i.add(() => PostProfessorGradeUsecase(repository: i()));
    i.add(() => UpdateProfessorGradeUsecase(repository: i()));
    i.add(() => GetProfessorGradesUsecase(repository: i()));
    i.add(() => GetProfessorGradesCountUsecase(repository: i()));
    i.add(() => GetGlobalGradeUsecase(repository: i()));
    i.add(() => PostProfessorGradeLikeDislikeUsecase(repository: i()));
    i.add(() => GetProfessorGradeByUserUsecase(repository: i()));

    i.add(
      () => SplashPipelineUseCase(
        dioConfig: i(),
        store: i(),
        networkInfo: i(),
      ),
    );

    // --------------------- REPOSITORIES ---------------------
    i.add<IInstitutoRepository>(() => InstitutoRepository(datasource: i()));
    i.add<IProfessorRepository>(() => ProfessorRepository(datasource: i()));

    // --------------------- DATA SOURCES ---------------------
    i.add<IInstitutoDatasource>(() => InstitutoDatasource(dio: i()));
    i.add<IProfessorDatasource>(() => ProfessorsDatasource(dio: i()));
    i.add<ILoginDatasource>(() => LoginDatasource(dio: i()));

    // ----------------------- SERVICES -----------------------
    i.add(() => AppInfo.instance);
    i.addSingleton<INetworkInfo>(() => NetworkInfo());
    i.add<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);
    i.add<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
    i.add<ILoginService>(() => LoginService(loginDatasource: i()));
    i.addSingleton(() => Dio());
    i.addLazySingleton(
      () => DioConfig(
        url: url,
        dio: i(),
      ),
    );

    i.add<Box>(() => Hive.box('melivra'));

    super.exportedBinds(i);
  }
}
