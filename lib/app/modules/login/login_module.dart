import 'package:app_melivra/app/modules/login/data/datasources/login_datasource.dart';
import 'package:app_melivra/app/modules/login/domain/usecases/login_usecase.dart';
import 'package:app_melivra/app/modules/login/presentation/bloc/login_bloc.dart';
import 'package:app_melivra/app/modules/login/presentation/controllers/login_controller.dart';
import 'package:app_melivra/app/modules/login/presentation/pages/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/services/login_service.dart';

class LoginModule extends Module {
  static String routeName = '/login/';
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController(bloc: i(), store: i(), loginUsecase: i())),
        Bind((i) => LoginBloc()),
        Bind((i) => LoginDatasource(dio: i())),
        Bind((i) => LoginService(loginDatasource: i())),
        Bind((i) => LoginUsecase(service: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const LoginPage(),
        ),
      ];
}
