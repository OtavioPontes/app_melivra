import 'dart:convert';

import 'package:equatable/equatable.dart';

class Grade extends Equatable {
  final int coherentEvaluation;
  final int clearExplanation;
  final int respectfulTreatment;
  final int boardOrganization;
  final int average;

  const Grade({
    required this.coherentEvaluation,
    required this.clearExplanation,
    required this.respectfulTreatment,
    required this.boardOrganization,
    required this.average,
  });

  @override
  List<Object> get props => [
        average,
        coherentEvaluation,
        clearExplanation,
        respectfulTreatment,
        boardOrganization,
      ];

  Grade copyWith(
      {int? coherentEvaluation,
      int? clearExplanation,
      int? respectfulTreatment,
      int? boardOrganization,
      int? average}) {
    return Grade(
      average: average ?? this.average,
      coherentEvaluation: coherentEvaluation ?? this.coherentEvaluation,
      clearExplanation: clearExplanation ?? this.clearExplanation,
      respectfulTreatment: respectfulTreatment ?? this.respectfulTreatment,
      boardOrganization: boardOrganization ?? this.boardOrganization,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'average': average,
      'coherentEvaluation': coherentEvaluation,
      'clearExplanation': clearExplanation,
      'respectfulTreatment': respectfulTreatment,
      'boardOrganization': boardOrganization,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      average: map['average']?.toInt() ?? 0,
      coherentEvaluation: map['coherentEvaluation']?.toInt() ?? 0,
      clearExplanation: map['clearExplanation']?.toInt() ?? 0,
      respectfulTreatment: map['respectfulTreatment']?.toInt() ?? 0,
      boardOrganization: map['boardOrganization']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Grade.fromJson(String source) => Grade.fromMap(json.decode(source));
}
