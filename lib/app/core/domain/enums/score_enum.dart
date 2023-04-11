import 'package:app_melivra/app/core/style/colors.dart';
import 'package:flutter/material.dart';

/// [0 - 49] -> Bad
/// [50 - 79] -> Average
/// [80 - 100] -> Good

enum ScoreEnum { good, average, bad, undefined }

class UtilsScoreEnum {
  static ScoreEnum getEnumFromScore({required int? score}) {
    if (score == null) {
      return ScoreEnum.undefined;
    }
    if (score >= 0 && score <= 39) {
      return ScoreEnum.bad;
    }
    if (score >= 40 && score <= 69) {
      return ScoreEnum.average;
    }
    if (score >= 70 && score <= 100) {
      return ScoreEnum.good;
    }
    return ScoreEnum.bad;
  }
}

extension ScoreEnumExtension on ScoreEnum {
  Color get getColor {
    switch (this) {
      case ScoreEnum.undefined:
        return ColorsMeLivra().grey;
      case ScoreEnum.bad:
        return ColorsMeLivra().red;
      case ScoreEnum.average:
        return ColorsMeLivra().yellow;
      case ScoreEnum.good:
        return ColorsMeLivra().green;
    }
  }
}
