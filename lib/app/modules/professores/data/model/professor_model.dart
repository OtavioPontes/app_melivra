import 'dart:convert';

import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';

import 'package:app_melivra/app/core/domain/entities/grade.dart';

import '../../../institutos/data/models/instituto_model.dart';
import '../../domain/entities/professor_entity.dart';

class ProfessorModel extends Professor {
  const ProfessorModel({
    required int id,
    required String name,
    required Instituto instituto,
    Grade? grades,
    int? averageGrade,
  }) : super(
          id: id,
          name: name,
          instituto: instituto,
          grades: grades,
          averageGrade: averageGrade,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'institute': InstitutoModel.fromEntity(instituto).toMap(),
      'grades': grades?.toMap(),
      'averageGrade': averageGrade
    };
  }

  factory ProfessorModel.fromMap(Map<String, dynamic> map) {
    return ProfessorModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      instituto: InstitutoModel.fromMap(map['institute']).toEntity(),
      averageGrade: map['grade'],
      grades: map['grades'] != null
          ? Grade.fromMap(
              map['grades'],
            )
          : null,
    );
  }

  Professor toEntity() {
    return Professor(
        id: id,
        name: name,
        instituto: instituto,
        grades: grades,
        averageGrade: averageGrade);
  }

  factory ProfessorModel.fromEntity(Professor professor) {
    return ProfessorModel(
        id: professor.id,
        name: professor.name,
        instituto: professor.instituto,
        grades: professor.grades,
        averageGrade: professor.averageGrade);
  }

  String toJson() => json.encode(toMap());

  factory ProfessorModel.fromJson(String source) =>
      ProfessorModel.fromMap(json.decode(source));
}
