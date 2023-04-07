import 'dart:math';

import 'package:app_melivra/app/core/domain/enums/score_enum.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';

class ScoreTinyWidget extends StatelessWidget {
  final int? score;
  const ScoreTinyWidget({
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
          height: 30.scale,
          width: 30.scale,
          child: Transform.rotate(
            angle: pi,
            child: CircularProgressIndicator(
              color: scoreEnum.getColor,
              value: score != null ? score! / 100 : 0,
              strokeWidth: 5,
            ),
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
            ),
          ),
          child: Center(
            child: Text(
              score != null ? score.toString() : '-',
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
