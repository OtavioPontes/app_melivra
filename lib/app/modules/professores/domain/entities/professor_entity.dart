import 'dart:convert';

import 'package:app_melivra/app/modules/institutos/data/models/instituto_model.dart';
import 'package:equatable/equatable.dart';

import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';

class Professor extends Equatable {
  final int id;
  final String name;
  final Instituto instituto;
  final Grade? grade;

  const Professor({
    required this.id,
    required this.name,
    required this.instituto,
    this.grade,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        instituto,
        grade,
      ];

  Professor copyWith({
    int? id,
    String? name,
    Instituto? instituto,
    Grade? grade,
  }) {
    return Professor(
      id: id ?? this.id,
      name: name ?? this.name,
      instituto: instituto ?? this.instituto,
      grade: grade ?? this.grade,
    );
  }
}
