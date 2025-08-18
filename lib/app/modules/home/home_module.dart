import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  static const String routeName = '/home/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => HomePage(),
    );
  }
}
