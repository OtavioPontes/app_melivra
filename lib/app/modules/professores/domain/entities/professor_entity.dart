import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:equatable/equatable.dart';

class Professor extends Equatable {
  final int id;
  final String name;
  final Instituto instituto;
  final Grade? grades;
  final int? averageGrade;

  const Professor({
    required this.id,
    required this.name,
    required this.instituto,
    this.grades,
    this.averageGrade,
  });

  @override
  List<Object?> get props => [id, name, instituto, grades, averageGrade];

  Professor copyWith({
    int? id,
    String? name,
    Instituto? instituto,
    Grade? grades,
    int? averageGrade,
  }) {
    return Professor(
      id: id ?? this.id,
      name: name ?? this.name,
      instituto: instituto ?? this.instituto,
      grades: grades ?? this.grades,
      averageGrade: averageGrade ?? this.averageGrade,
    );
  }
}
