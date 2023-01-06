import 'package:app_melivra/app/modules/search/presentation/controllers/search_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/search_page.dart';

class SearchModule extends Module {
  static const String routeName = "/search/";

  @override
  List<Bind> get binds => [
        Bind(
          (i) => SearchController(
            searchProfessorsBloc: i(),
            searchInstitutesBloc: i(),
            getInstitutosUsecase: i(),
            getProfessorsUsecase: i(),
          ),
        ),
      ];

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
