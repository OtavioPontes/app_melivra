import 'dart:convert';

import 'package:equatable/equatable.dart';

class Grade extends Equatable {
  final int? coherentEvaluation;
  final int? clearExplanation;
  final int? respectfulTreatment;
  final int? boardOrganization;
  final int? average;

  const Grade({
    required this.coherentEvaluation,
    required this.clearExplanation,
    required this.respectfulTreatment,
    required this.boardOrganization,
    this.average,
  });

  @override
  List<Object?> get props => [
        average,
        coherentEvaluation,
        clearExplanation,
        respectfulTreatment,
        boardOrganization,
      ];

  Grade copyWith({
    int? coherentEvaluation,
    int? clearExplanation,
    int? respectfulTreatment,
    int? boardOrganization,
    int? average,
  }) {
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
      if (average != null) 'average': average,
      'coherent_evaluation': coherentEvaluation,
      'clear_explanation': clearExplanation,
      'respectful_treatment': respectfulTreatment,
      'board_organization': boardOrganization,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      average: map['average_grade']?.toInt(),
      coherentEvaluation: map['coherent_evaluation']?.toInt(),
      clearExplanation: map['clear_explanation']?.toInt(),
      respectfulTreatment: map['respectful_treatment']?.toInt(),
      boardOrganization: map['board_organization']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Grade.fromJson(String source) => Grade.fromMap(json.decode(source));
}
