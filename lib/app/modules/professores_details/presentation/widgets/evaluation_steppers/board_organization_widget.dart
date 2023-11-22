import 'package:app_melivra/app/core/domain/enums/score_enum.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class BoardOrganizationWidget extends StatefulWidget {
  const BoardOrganizationWidget({Key? key}) : super(key: key);

  @override
  State<BoardOrganizationWidget> createState() =>
      _BoardOrganizationWidgetState();
}

class _BoardOrganizationWidgetState extends State<BoardOrganizationWidget> {
  final EvaluateProfessorController controller =
      Modular.get<EvaluateProfessorController>();

  final tutorialKey = GlobalKey();

  double value = 0;

  @override
  void initState() {
    value = controller.boardOrganizationValue.toDouble();
    showTutorial();
    super.initState();
  }

  final textController = TextEditingController();

  Future<void> showTutorial() async {
    if (!await controller.getHasTutorial()) {
      return;
    }
    // ignore: use_build_context_synchronously
    TutorialCoachMark(
      targets: [
        TargetFocus(
          identify: "evaluate",
          keyTarget: tutorialKey,
          contents: [
            TargetContent(
              padding: EdgeInsets.all(50.scale),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.scale),
                  const Text(
                    "Como avaliar o Professor? 🤔",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Basta arrastar o círculo acima, ou clicar no número e digitar a nota",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      textSkip: 'Pular',
      onSkip: controller.setHasTutorial,
      textStyleSkip: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ).show(context: context);
  }

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
              key: tutorialKey,
              onChange: (value) {
                setState(() {
                  this.value = value;
                  textController.text = value.toStringAsFixed(0);
                });
              },
              onChangeEnd: (value) {
                this.value = value;
                controller.boardOrganizationValue = value.toInt();
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
                              controller.boardOrganizationValue.toString(),
                        ),
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            this.value = double.parse(value);
                            controller.boardOrganizationValue =
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
              'Organização do Quadro',
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(
              height: 24.scale,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.scale),
              child: Text(
                'Ao manter o quadro organizado e informativo, é reforçado o que está sendo discutido em sala de aula e ajuda os alunos a acompanhar melhor o conteúdo.',
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
