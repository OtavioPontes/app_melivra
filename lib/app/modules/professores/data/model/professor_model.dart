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
    Grade? grade,
  }) : super(
          id: id,
          name: name,
          instituto: instituto,
          grade: grade,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'institute': InstitutoModel.fromEntity(instituto).toMap(),
      'grade': grade?.toMap(),
    };
  }

  factory ProfessorModel.fromMap(Map<String, dynamic> map) {
    return ProfessorModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      instituto: InstitutoModel.fromMap(map['institute']).toEntity(),
      grade: map['grade'] != null
          ? Grade.fromMap(
              map['grade'],
            )
          : null,
    );
  }

  Professor toEntity() {
    return Professor(
      id: id,
      name: name,
      instituto: instituto,
      grade: grade,
    );
  }

  factory ProfessorModel.fromEntity(Professor professor) {
    return ProfessorModel(
      id: professor.id,
      name: professor.name,
      instituto: professor.instituto,
      grade: professor.grade,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfessorModel.fromJson(String source) =>
      ProfessorModel.fromMap(json.decode(source));
}
