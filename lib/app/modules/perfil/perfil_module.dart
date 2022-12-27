import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';
import 'package:app_melivra/app/modules/perfil/presentation/pages/perfil_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfilModule extends Module {
  static const String routeName = "/perfil/";
  static ModularProvider provider = ModularProvider(
    module: PerfilModule(),
    child: PerfilPage(),
  );
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilController(store: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => PerfilPage(),
        ),
      ];
}
