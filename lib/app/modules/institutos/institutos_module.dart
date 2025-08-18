import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/institutos/presentation/pages/institutos_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InstitutosModule extends Module {
  static const String routeName = '/institutos/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => InstitutosPage(),
    );
  }
}
