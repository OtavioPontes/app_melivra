import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:app_melivra/app/modules/splash/presentation/controller/splash_controller.dart';
import 'package:app_melivra/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  static const String routeName = '/splash/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    super.binds(i);
    i.add(SplashBloc.new);
    i.add(
      () => SplashController(
        bloc: i(),
        appInfo: AppInfo.instance,
        pipeline: i(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const SplashPage(),
    );
  }
}
