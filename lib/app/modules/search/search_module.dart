import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/search_page.dart';

class SeachModule extends Module {
  static const String routeName = "/search/";

  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          transition: TransitionType.noTransition,
          child: (context, args) => SearchPage(
            onlyInstitutos: args.data?['onlyInstitutos'],
            onlyProfessor: args.data?['onlyProfessores'],
          ),
        )
      ];
}
