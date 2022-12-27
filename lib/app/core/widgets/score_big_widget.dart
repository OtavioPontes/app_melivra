import 'dart:math';

import 'package:app_melivra/app/core/domain/enums/score_enum.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';

class ScoreBigWidget extends StatelessWidget {
  final int score;
  const ScoreBigWidget({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScoreEnum scoreEnum = UtilsScoreEnum.getEnumFromScore(score: score);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 130.scale,
          width: 130.scale,
          child: Transform.rotate(
            angle: pi,
            child: CircularProgressIndicator(
              color: scoreEnum.getColor,
              value: score / 100,
              strokeWidth: 8,
            ),
          ),
        ),
        Container(
          height: 100.scale,
          width: 100.scale,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: theme.cardColor,
              width: 15,
            ),
          ),
          child: Center(
            child: Text(
              score.toString(),
              style: theme.textTheme.headline3,
            ),
          ),
        ),
      ],
    );
  }
}
