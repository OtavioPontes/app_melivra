import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../core/domain/enums/score_enum.dart';
import '../controllers/evalute_professor_controller.dart';

class CoherentEvaluationWidget extends StatefulWidget {
  const CoherentEvaluationWidget({Key? key}) : super(key: key);

  @override
  State<CoherentEvaluationWidget> createState() =>
      _CoherentEvaluationWidgetState();
}

class _CoherentEvaluationWidgetState extends State<CoherentEvaluationWidget> {
  final EvaluateProfessorController controller =
      Modular.get<EvaluateProfessorController>();

  @override
  Widget build(BuildContext context) {
    Color barColor = UtilsScoreEnum.getEnumFromScore(
            score: controller.coherentEvaluationValue)
        .getColor;
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.scale),
        child: Column(
          children: [
            SleekCircularSlider(
              onChange: (value) {
                controller.coherentEvaluationValue = value.toInt();
                setState(
                  () {
                    controller.coherentEvaluationValue = value.toInt();
                  },
                );
              },
              initialValue: controller.coherentEvaluationValue.toDouble(),
              innerWidget: (percentage) => Center(
                child: Text(
                  percentage.toInt().toString(),
                  style: theme.textTheme.headline4,
                ),
              ),
              min: 1,
              max: 101,
              appearance: CircularSliderAppearance(
                size: 140,
                customWidths: CustomSliderWidths(progressBarWidth: 9),
                startAngle: 90,
                angleRange: 360,
                customColors: CustomSliderColors(
                  trackColor: Colors.transparent,
                  progressBarColor: barColor,
                  dynamicGradient: false,
                ),
              ),
            ),
            SizedBox(
              height: 32.scale,
            ),
            Text(
              'Avaliação Coerente',
              style: theme.textTheme.headline6,
            ),
            SizedBox(
              height: 16.scale,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}