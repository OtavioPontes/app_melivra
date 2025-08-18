import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/sobre_app/presentation/pages/sobre_app_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SobreAppModule extends Module {
  static const String routeName = '/sobreApp/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const SobreAppPage(),
    );
  }
}
