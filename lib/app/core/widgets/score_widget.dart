import 'dart:math';

import 'package:app_melivra/app/core/domain/enums/score_enum.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int? score;
  const ScoreWidget({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scoreEnum = UtilsScoreEnum.getEnumFromScore(score: score);
    return SizedBox(
      height: 50.scale,
      width: 50.scale,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Transform.rotate(
              angle: pi,
              child: CircularProgressIndicator(
                color: scoreEnum.getColor,
                value: score != null ? score! / 100 : 0,
                strokeWidth: 8,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: theme.cardColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                score != null ? score.toString() : '-',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
