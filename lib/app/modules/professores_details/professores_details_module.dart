import 'package:app_melivra/app/modules/professores_details/presentation/bloc/professor_details_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/professores_details_page.dart';

class ProfessoresDetailsModule extends Module {
  static const String routeName = "/professoresDetails/";
  @override
  List<Bind> get binds => [
        Bind((i) => ProfessorDetailsBloc()),
        Bind(
          (i) => ProfessorDetailsController(
            getProfessorDetailsUsecase: i(),
            bloc: i(),
            id: i.args.data['id'],
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const ProfessoresDetailsPage(),
        ),
      ];
}
