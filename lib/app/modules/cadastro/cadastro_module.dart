import 'package:app_melivra/app/modules/cadastro/presentation/cadastro_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroModule extends Module {
  static String routeName = '/cadastro/';

  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const CadastroPage(),
        )
      ];
}
