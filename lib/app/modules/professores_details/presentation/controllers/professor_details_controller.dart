import 'package:app_melivra/app/core/domain/entities/grade_response.dart';
import 'package:app_melivra/app/core/domain/entities/grades_response_config.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professor_grades_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/update_professor_grade_usecase.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/show_button_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:profanity_filter/profanity_filter.dart';

import '../../../../core/utils/bad_words.dart';
import '../../../professores/domain/usecases/get_professor_details_usecase.dart';
import '../bloc/professor_details_bloc.dart';
import '../bloc/professor_grades_bloc.dart';

class ProfessorDetailsController {
  final GetProfessorDetailsUsecase _getProfessorDetailsUsecase;
  final GetProfessorGradesUsecase _getProfessorGradesUsecase;
  final UpdateProfessorGradeUsecase _updateProfessorGradeUsecase;
  final ProfessorDetailsBloc bloc;
  final ProfessorGradesBloc gradesBloc;
  final ShowEvaluationButtonBloc showButtonBloc;
  final int id;

  GradesResponseConfig? responseConfig;

  TextEditingController evaluationController = TextEditingController();

  DraggableScrollableController? scrollableController =
      DraggableScrollableController();

  final List<GradeResponse> grades = [];

  ProfessorDetailsController({
    required UpdateProfessorGradeUsecase updateProfessorGradeUsecase,
    required GetProfessorGradesUsecase getProfessorGradesUsecase,
    required GetProfessorDetailsUsecase getProfessorDetailsUsecase,
    required this.bloc,
    required this.gradesBloc,
    required this.showButtonBloc,
    required this.id,
  })  : _getProfessorDetailsUsecase = getProfessorDetailsUsecase,
        _updateProfessorGradeUsecase = updateProfessorGradeUsecase,
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

  Future<void> updateProfessorEvaluation() async {
    gradesBloc.add(
      ProfessorGradesLoadingEvent(),
    );

    final result = await _updateProfessorGradeUsecase(
      ParamsUpdateProfessorGradeUsecase(
        id: id,
        description: evaluationController.text,
      ),
    );
    result.fold(
      (failure) {
        gradesBloc.add(
          ProfessorGradesFailureEvent(message: failure.message),
        );
      },
      (success) async {
        evaluationController.clear();
        grades.clear();
        await getProfessorGrades(id: id);
      },
    );
  }
}
