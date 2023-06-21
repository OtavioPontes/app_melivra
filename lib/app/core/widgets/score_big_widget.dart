import 'dart:math';

import 'package:app_melivra/app/core/domain/enums/score_enum.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';

class ScoreBigWidget extends StatelessWidget {
  final int? score;
  const ScoreBigWidget({
    Key? key,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scoreEnum = UtilsScoreEnum.getEnumFromScore(score: score);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 150.scale,
          width: 150.scale,
          child: Transform.rotate(
            angle: pi,
            child: CircularProgressIndicator(
              color: scoreEnum.getColor,
              value: score != null ? score! / 100 : 0,
              strokeWidth: 8,
            ),
          ),
        ),
        Text(
          score != null ? score.toString() : '-',
          style: theme.textTheme.displaySmall,
        ),
      ],
    );
  }
}
