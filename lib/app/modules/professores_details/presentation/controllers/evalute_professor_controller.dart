import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores_details/domain/services/i_send_report_service.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/evaluate_professor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../professores/domain/usecases/post_professor_grade_usecase.dart';

class EvaluateProfessorController {
  final PostProfessorGradeUsecase _postProfessorGradeUsecase;
  final ISendReportService _sendReportService;
  final EvaluateProfessorBloc bloc;
  final PageController pageController = PageController();
  final TextEditingController reportController = TextEditingController();
  final Box _box;

  Professor? professor;

  int boardOrganizationValue = 50;
  int clearExplanationValue = 50;
  int coherentEvaluationValue = 50;
  int respectfulTreatmentValue = 50;

  int currentIndex = 0;

  EvaluateProfessorController({
    required ISendReportService sendReportService,
    required PostProfessorGradeUsecase postProfessorGradeUsecase,
    required Box box,
    required this.bloc,
  })  : _postProfessorGradeUsecase = postProfessorGradeUsecase,
        _sendReportService = sendReportService,
        _box = box;

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

  Future<void> sendReport({required int id}) async {
    final result = await _sendReportService(
      description: reportController.text,
      id: id,
    );
    await result.fold(
      (l) => Fluttertoast.showToast(
        msg: "Falha ao enviar denúncia 😥",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 12,
      ),
      (success) {
        reportController.clear();
        return Fluttertoast.showToast(
          msg: "Denúncia enviada com sucesso ✅",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 12,
        );
      },
    );
    return;
  }

  Future<bool> setHasTutorial() async {
    await _box.put('hasTutorial', false);
    return true;
  }

  Future<bool> getHasTutorial() async {
    return _box.get('hasTutorial', defaultValue: true);
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
