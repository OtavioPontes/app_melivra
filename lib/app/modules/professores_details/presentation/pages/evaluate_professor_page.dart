import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/evaluation_steppers/board_organization_widget.dart';
import '../widgets/evaluation_steppers/clear_explanation_widget.dart';
import '../widgets/evaluation_steppers/coherent_evaluation_widget.dart';
import '../widgets/evaluation_steppers/respectful_treatment_widget.dart';

class EvaluateProfessorPage extends StatelessWidget {
  const EvaluateProfessorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<EvaluateProfessorController>();
    return Expanded(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.setCurrentIndex,
        children: const [
          BoardOrganizationWidget(),
          ClearExplanationWidget(),
          CoherentEvaluationWidget(),
          RespectfulTreatmentWidget()
        ],
      ),
    );
  }
}
