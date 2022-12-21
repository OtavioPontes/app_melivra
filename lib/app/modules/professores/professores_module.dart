import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/professores_page.dart';

class ProfessoresModule extends Module {
  static const String routeName = "/professores/";

  static ModularProvider provider = ModularProvider(
    module: ProfessoresModule(),
    child: const ProfessoresPage(),
  );

  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const ProfessoresPage(),
        )
      ];
}
