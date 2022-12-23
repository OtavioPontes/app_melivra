import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/professores_details_page.dart';

class ProfessoresDetailsModule extends Module {
  static const String routeName = "/professoresDetails/";
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const ProfessoresDetailsPage(),
        ),
      ];
}
