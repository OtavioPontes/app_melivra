import 'package:app_melivra/app/modules/ranking_institutos/presentation/bloc/ranking_bloc.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/controllers/ranking_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/ranking_page.dart';

class RankingInstitutosModule extends Module {
  static String routeName = "/ranking/";
  @override
  List<Bind> get binds => [
        Bind((i) => RankingBloc()),
        Bind(
          (i) => RankController(
            bloc: i(),
            getInstitutosRankUsecase: i(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => RankingPage(),
        ),
      ];
}
