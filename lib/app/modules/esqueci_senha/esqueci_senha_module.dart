import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/esqueci_senha_page.dart';

class EsqueciSenhaModule extends Module {
  static String routeName = '/esqueciSenha/';
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const EsqueciSenhaPage(),
        )
      ];
}
