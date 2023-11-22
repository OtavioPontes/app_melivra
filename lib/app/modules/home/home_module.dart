import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  static String routeName = '/home/';

  static ModularProvider get provider => ModularProvider(
        module: HomeModule(),
        child: HomePage(),
      );

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => HomePage(),
        ),
      ];
}
