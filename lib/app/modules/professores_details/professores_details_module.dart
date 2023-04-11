import 'package:app_melivra/app/modules/professores_details/data/services/send_report_service.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/evaluate_professor_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/professor_details_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/professor_grades_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/show_button_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/professores_details_page.dart';

class ProfessoresDetailsModule extends Module {
  static const String routeName = "/professoresDetails/";
  @override
  List<Bind> get binds => [
        Bind((i) => EvaluateProfessorBloc()),
        Bind((i) => ProfessorGradesBloc()),
        Bind((i) => ProfessorDetailsBloc()),
        Bind((i) => ShowEvaluationButtonBloc()),
        Bind((i) => SendReportService(dio: i())),
        Bind(
          (i) => ProfessorDetailsController(
            getProfessorGradesCountUsecase: i(),
            updateProfessorGradeUsecase: i(),
            showButtonBloc: i(),
            getProfessorGradesUsecase: i(),
            getProfessorDetailsUsecase: i(),
            gradesBloc: i(),
            bloc: i(),
            id: i.args.data['id'],
          ),
        ),
        Bind(
          (i) => EvaluateProfessorController(
            sendReportService: i(),
            postProfessorGradeUsecase: i(),
            bloc: i(),
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
