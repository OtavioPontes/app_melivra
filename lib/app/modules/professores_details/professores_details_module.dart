import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/professores_details/data/services/send_report_service.dart';
import 'package:app_melivra/app/modules/professores_details/domain/services/i_send_report_service.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/evaluate_professor_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/professor_details_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/professor_grades_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/show_button_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/pages/professores_details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfessoresDetailsModule extends Module {
  static const String routeName = '/professoresDetails/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add(EvaluateProfessorBloc.new);
    i.add(ProfessorGradesBloc.new);
    i.add(ProfessorDetailsBloc.new);
    i.add(ShowEvaluationButtonBloc.new);
    i.add<ISendReportService>(() => SendReportService(dio: i()));
    i.addSingleton(
      () => ProfessorDetailsController(
        getProfessorGradeByUserUsecase: i(),
        postProfessorGradeLikeDislikeUsecase: i(),
        getProfessorGradesCountUsecase: i(),
        updateProfessorGradeUsecase: i(),
        showButtonBloc: i(),
        getProfessorGradesUsecase: i(),
        getProfessorDetailsUsecase: i(),
        gradesBloc: i(),
        bloc: i(),
        id: i.args.data['id'],
      ),
    );
    i.addSingleton(
      () => EvaluateProfessorController(
        box: i(),
        sendReportService: i(),
        postProfessorGradeUsecase: i(),
        bloc: i(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const ProfessoresDetailsPage(),
    );
  }
}
