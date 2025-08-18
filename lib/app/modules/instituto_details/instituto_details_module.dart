import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_details_bloc.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_professors_bloc.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/controllers/instituto_details_controller.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/pages/instituto_details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InstitutoDetailsModule extends Module {
  static const String routeName = '/institutoDetails/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add(InstitutoDetailsBloc.new);
    i.add(InstitutoProfessorsBloc.new);
    i.add(
      () => InstitutoDetailsController(
        professorsBloc: i(),
        getProfessorsUsecase: i(),
        getInstitutoDetailsUsecase: i(),
        bloc: i(),
        id: i.args.data['id'],
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const InstitutoDetailsPage(),
    );
  }
}
