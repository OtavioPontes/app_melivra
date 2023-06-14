import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../../core/domain/enums/score_enum.dart';
import '../../controllers/evalute_professor_controller.dart';

class RespectfulTreatmentWidget extends StatefulWidget {
  const RespectfulTreatmentWidget({Key? key}) : super(key: key);

  @override
  State<RespectfulTreatmentWidget> createState() =>
      _RespectfulTreatmentWidgetState();
}

class _RespectfulTreatmentWidgetState extends State<RespectfulTreatmentWidget> {
  final EvaluateProfessorController controller =
      Modular.get<EvaluateProfessorController>();

  @override
  Widget build(BuildContext context) {
    final barColor = UtilsScoreEnum.getEnumFromScore(
      score: controller.respectfulTreatmentValue,
    ).getColor;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.scale),
        child: Column(
          children: [
            SleekCircularSlider(
              onChange: (value) {
                controller.respectfulTreatmentValue = value.toInt();
                setState(
                  () {
                    controller.respectfulTreatmentValue = value.toInt();
                  },
                );
              },
              initialValue: controller.respectfulTreatmentValue.toDouble(),
              innerWidget: (percentage) => Center(
                child: Text(
                  percentage.toInt().toString(),
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              min: 1,
              max: 101,
              appearance: CircularSliderAppearance(
                size: 160,
                customWidths: CustomSliderWidths(progressBarWidth: 10),
                startAngle: 90,
                angleRange: 360,
                customColors: CustomSliderColors(
                  trackColor: Colors.transparent,
                  progressBarColor: barColor,
                ),
              ),
            ),
            SizedBox(
              height: 32.scale,
            ),
            Text(
              'Tratamento Respeitoso',
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(
              height: 24.scale,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.scale),
              child: Text(
                'O tratamento respeitoso ajuda a estabelecer uma atmosfera de aprendizado colaborativa e eficaz.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 24.scale,
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  // Change your radius here
                  borderRadius: BorderRadius.circular(12),
                ),
                fixedSize: Size(140.scale, 40.scale),
                backgroundColor: theme.primaryColor,
              ),
              onPressed: () =>
                  controller.evaluateProfessor(id: controller.professor!.id),
              child: Text(
                'Finalizar',
                style: theme.textTheme.titleLarge!.merge(
                  TextStyle(
                    color: theme.colorScheme.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}