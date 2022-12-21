import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/ranking_page.dart';

class RankingInstitutosModule extends Module {
  static String routeName = "/ranking/";
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const RankingPage(),
        ),
      ];
}
