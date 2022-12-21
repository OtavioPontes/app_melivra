import 'package:app_melivra/app/modules/perfil/presentation/pages/perfil_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfilModule extends Module {
  static const String routeName = "/perfil/";
  static ModularProvider provider = ModularProvider(
    module: PerfilModule(),
    child: const PerfilPage(),
  );
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const PerfilPage(),
        ),
      ];
}
