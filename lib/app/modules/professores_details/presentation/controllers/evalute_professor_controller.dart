import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:flutter/material.dart';

import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/evaluate_professor_bloc.dart';

import '../../../professores/domain/usecases/post_professor_grade_usecase.dart';

class EvaluateProfessorController {
  final PostProfessorGradeUsecase _postProfessorGradeUsecase;
  final EvaluateProfessorBloc bloc;
  final PageController pageController = PageController(initialPage: 0);

  Professor? professor;

  int boardOrganizationValue = 50;
  int clearExplanationValue = 50;
  int coherentEvaluationValue = 50;
  int respectfulTreatmentValue = 50;

  int currentIndex = 0;

  EvaluateProfessorController({
    required PostProfessorGradeUsecase postProfessorGradeUsecase,
    required this.bloc,
  }) : _postProfessorGradeUsecase = postProfessorGradeUsecase;

  void setCurrentIndex(int index) => currentIndex = index;

  void setProfessor(Professor professor) => this.professor = professor;

  void animatedToIndex() {
    pageController.jumpToPage(
      currentIndex,
    );
  }

  Future<void> evaluateProfessor({required int id}) async {
    final result = await _postProfessorGradeUsecase(
      ParamsPostProfessorGradeUsecase(
        id: id,
        grade: Grade(
          coherentEvaluation: coherentEvaluationValue,
          clearExplanation: clearExplanationValue,
          respectfulTreatment: respectfulTreatmentValue,
          boardOrganization: boardOrganizationValue,
        ),
      ),
    );
    result.fold(
      (failure) {
        bloc.add(
          EvaluateProfessorFailureEvent(
            message: failure.message,
          ),
        );
      },
      (success) {
        bloc.add(
          EvaluateProfessorSuccessEvent(),
        );
      },
    );
  }

  void dispose() {
    bloc.add(EvaluateProfessorResetEvent());
    currentIndex = 0;
    boardOrganizationValue = 50;
    clearExplanationValue = 50;
    coherentEvaluationValue = 50;
    respectfulTreatmentValue = 50;
  }
}
