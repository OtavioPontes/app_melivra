import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/search/presentation/controllers/search_controller.dart';
import 'package:app_melivra/app/modules/search/presentation/pages/search_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  static const String routeName = '/search/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add(
      () => SearchController(
        searchProfessorsBloc: i(),
        searchInstitutesBloc: i(),
        getInstitutosUsecase: i(),
        getProfessorsUsecase: i(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => SearchPage(
        onlyInstitutos: r.args.data?['onlyInstitutos'],
        onlyProfessor: r.args.data?['onlyProfessores'],
      ),
    );
  }
}
