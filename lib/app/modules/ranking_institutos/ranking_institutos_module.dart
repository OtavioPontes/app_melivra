import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/bloc/ranking_bloc.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/controllers/ranking_controller.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/pages/ranking_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RankingInstitutosModule extends Module {
  static const String routeName = '/ranking/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add(RankingBloc.new);
    i.add(
      () => RankController(
        bloc: i(),
        getInstitutosRankUsecase: i(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => RankingPage(),
    );
  }
}
