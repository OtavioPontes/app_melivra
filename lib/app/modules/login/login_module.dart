import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/login/domain/usecases/login_usecase.dart';
import 'package:app_melivra/app/modules/login/presentation/bloc/login_bloc.dart';
import 'package:app_melivra/app/modules/login/presentation/controllers/login_controller.dart';
import 'package:app_melivra/app/modules/login/presentation/pages/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  static const String routeName = '/login/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add(LoginBloc.new);
    i.add(() => LoginController(bloc: i(), store: i(), loginUsecase: i()));
    i.add(() => LoginUsecase(service: i()));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const LoginPage(),
    );
  }
}
