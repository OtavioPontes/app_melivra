import 'dart:math';

import 'package:app_melivra/app/core/domain/enums/score_enum.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';

class ScoreTinyWidget extends StatelessWidget {
  final int score;
  const ScoreTinyWidget({
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
        Transform.rotate(
          angle: pi,
          child: CircularProgressIndicator(
            color: scoreEnum.getColor,
            value: score / 100,
            strokeWidth: 5,
          ),
        ),
        Container(
          height: 30.scale,
          width: 30.scale,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: theme.cardColor,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              score.toString(),
              style: theme.textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }
}
