import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../../core/domain/enums/score_enum.dart';
import '../../controllers/evalute_professor_controller.dart';

class CoherentEvaluationWidget extends StatefulWidget {
  const CoherentEvaluationWidget({Key? key}) : super(key: key);

  @override
  State<CoherentEvaluationWidget> createState() =>
      _CoherentEvaluationWidgetState();
}

class _CoherentEvaluationWidgetState extends State<CoherentEvaluationWidget> {
  final EvaluateProfessorController controller =
      Modular.get<EvaluateProfessorController>();

  double value = 0;

  @override
  void initState() {
    value = controller.coherentEvaluationValue.toDouble();
    super.initState();
  }

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final barColor = UtilsScoreEnum.getEnumFromScore(
      score: value.toInt(),
    ).getColor;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.scale),
        child: Column(
          children: [
            SleekCircularSlider(
              onChange: (value) {
                setState(() {
                  this.value = value;
                  textController.text = value.toStringAsFixed(0);
                });
              },
              onChangeEnd: (value) {
                controller.coherentEvaluationValue = value.toInt();
              },
              initialValue: value,
              innerWidget: (percentage) {
                return Center(
                  child: IntrinsicWidth(
                    child: TextFormField(
                      controller: textController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('')),
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r'\b([1-9]|[1-9][0-9]|100)\b',
                          ),
                          replacementString:
                              controller.coherentEvaluationValue.toString(),
                        ),
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            this.value = double.parse(value);
                            controller.coherentEvaluationValue =
                                int.parse(value);
                          });
                        }
                      },
                      maxLength: 3,
                      style: theme.textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.zero,
                        hintText: percentage.toInt().toString(),
                        hintStyle: theme.textTheme.headlineMedium,
                      ),
                    ),
                  ),
                );
              },
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
              'Avaliação Coerente',
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(
              height: 24.scale,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.scale),
              child: Text(
                'Uma avaliação coerente pode ajudar a avaliar o progresso dos alunos e auxiliar nas próximas etapas do processo de aprendizagem.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
