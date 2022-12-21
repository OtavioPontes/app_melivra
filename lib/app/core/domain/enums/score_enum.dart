import 'package:app_melivra/app/core/style/colors.dart';
import 'package:flutter/material.dart';

/// [0 - 49] -> Bad
/// [50 - 79] -> Average
/// [80 - 100] -> Good

enum ScoreEnum { good, average, bad }

class UtilsScoreEnum {
  static ScoreEnum getEnumFromScore({required int score}) {
    if (score >= 0 && score <= 49) {
      return ScoreEnum.bad;
    }
    if (score >= 50 && score <= 79) {
      return ScoreEnum.average;
    }
    if (score >= 80 && score <= 100) {
      return ScoreEnum.good;
    }
    return ScoreEnum.bad;
  }
}

extension ScoreEnumExtension on ScoreEnum {
  Color get getColor {
    switch (this) {
      case ScoreEnum.bad:
        return ColorsMeLivra().red;
      case ScoreEnum.average:
        return ColorsMeLivra().yellow;
      case ScoreEnum.good:
        return ColorsMeLivra().green;
      default:
        return ColorsMeLivra().green;
    }
  }
}
