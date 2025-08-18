import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/about_us/presentation/pages/about_us_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AboutUsModule extends Module {
  static const String routeName = '/aboutUs/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const AboutUsPage(),
    );
  }
}
