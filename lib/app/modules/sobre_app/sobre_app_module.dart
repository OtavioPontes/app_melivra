import 'package:app_melivra/app/modules/sobre_app/presentation/pages/sobre_app_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SobreAppModule extends Module {
  static const routeName = '/sobreApp/';
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => SobreAppPage(),
        ),
      ];
}
