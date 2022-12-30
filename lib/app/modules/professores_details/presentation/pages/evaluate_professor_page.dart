import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/board_organization_widget.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/clear_explanation_widget.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/coherent_evaluation_widget.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/respectful_treatment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EvaluateProfessorPage extends StatelessWidget {
  const EvaluateProfessorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EvaluateProfessorController controller =
        Modular.get<EvaluateProfessorController>();
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
