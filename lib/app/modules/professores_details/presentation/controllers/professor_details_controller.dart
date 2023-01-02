import 'package:app_melivra/app/core/domain/entities/grade_response.dart';
import 'package:app_melivra/app/core/domain/entities/grades_response_config.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professor_grades_usecase.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/show_button_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../professores/domain/usecases/get_professor_details_usecase.dart';
import '../bloc/professor_details_bloc.dart';
import '../bloc/professor_grades_bloc.dart';

class ProfessorDetailsController {
  final GetProfessorDetailsUsecase _getProfessorDetailsUsecase;
  final GetProfessorGradesUsecase _getProfessorGradesUsecase;
  final ProfessorDetailsBloc bloc;
  final ProfessorGradesBloc gradesBloc;
  final ShowEvaluationButtonBloc showButtonBloc;
  final int id;

  GradesResponseConfig? responseConfig;

  DraggableScrollableController? scrollableController =
      DraggableScrollableController();

  final List<GradeResponse> grades = [];

  ProfessorDetailsController({
    required GetProfessorGradesUsecase getProfessorGradesUsecase,
    required GetProfessorDetailsUsecase getProfessorDetailsUsecase,
    required this.bloc,
    required this.gradesBloc,
    required this.showButtonBloc,
    required this.id,
  })  : _getProfessorDetailsUsecase = getProfessorDetailsUsecase,
        _getProfessorGradesUsecase = getProfessorGradesUsecase {
    pipeline();
  }

  pipeline() async {
    showButtonBloc.add(
      ShowEvaluationButtonSuccessEvent(),
    );
    await getProfessorDetails(id: id);
    await getProfessorGrades(id: id);
  }

  void setShowButton(bool showButton) {
    if (showButton) {
      showButtonBloc.add(
        ShowEvaluationButtonSuccessEvent(),
      );
    } else {
      showButtonBloc.add(
        ShowEvaluationButtonFailureEvent(message: ''),
      );
    }
  }

  Future<void> getProfessorDetails({required int id}) async {
    bloc.add(
      ProfessorDetailsLoadingEvent(),
    );
    final result = await _getProfessorDetailsUsecase(
      ParamsGetProfessorDetailsUsecase(id: id),
    );
    result.fold(
      (failure) {
        bloc.add(
          ProfessorDetailsFailureEvent(message: failure.message),
        );
      },
      (professor) {
        return bloc.add(
          ProfessorDetailsSuccessEvent(professor: professor),
        );
      },
    );
  }

  Future<void> getProfessorGrades({required int id}) async {
    gradesBloc.add(
      ProfessorGradesLoadingEvent(),
    );
    final result = await _getProfessorGradesUsecase(
      ParamsGetProfessorGradesUsecase(id: id),
    );
    result.fold(
      (failure) {
        gradesBloc.add(
          ProfessorGradesFailureEvent(message: failure.message),
        );
      },
      (response) {
        responseConfig = response;
        grades.addAll(response.response);
        return gradesBloc.add(
          ProfessorGradesSuccessEvent(grades: grades),
        );
      },
    );
  }
}
