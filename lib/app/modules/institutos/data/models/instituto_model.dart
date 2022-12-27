import 'dart:convert';

import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';

class InstitutoModel extends Instituto {
  const InstitutoModel({
    required int id,
    required String name,
    required String initials,
    required Grade? grades,
    required int? averageGrade,
  }) : super(
          id: id,
          name: name,
          initials: initials,
          grades: grades,
          averageGrade: averageGrade,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'initials': initials,
      'grades': grades,
      'avg_grade': averageGrade,
    };
  }

  factory InstitutoModel.fromMap(Map<String, dynamic> map) {
    return InstitutoModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      initials: map['initials'] ?? '',
      grades: map['grades'] != null
          ? Grade.fromMap(
              map['grades'],
            )
          : null,
      averageGrade: map['avg_grade']?.toInt(),
    );
  }

  Instituto toEntity() {
    return Instituto(
      id: id,
      name: name,
      initials: initials,
      grades: grades,
      averageGrade: averageGrade,
    );
  }

  factory InstitutoModel.fromEntity(Instituto instituto) {
    return InstitutoModel(
      id: instituto.id,
      name: instituto.name,
      initials: instituto.initials,
      grades: instituto.grades,
      averageGrade: instituto.averageGrade,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstitutoModel.fromJson(String source) =>
      InstitutoModel.fromMap(json.decode(source));
}
