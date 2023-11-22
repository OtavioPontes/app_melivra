import 'package:app_melivra/app/modules/about_us/presentation/pages/about_us_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AboutUsModule extends Module {
  static const String routeName = '/aboutUs/';
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const AboutUsPage(),
        ),
      ];
}
