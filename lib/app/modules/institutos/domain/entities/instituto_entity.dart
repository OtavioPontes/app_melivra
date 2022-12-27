import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/grade.dart';

class Instituto extends Equatable {
  final int id;
  final String name;
  final String initials;
  final Grade? grades;
  final int? averageGrade;

  const Instituto({
    required this.id,
    required this.name,
    required this.initials,
    this.grades,
    this.averageGrade,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        initials,
        grades,
        averageGrade,
      ];

  Instituto copyWith({
    int? id,
    String? name,
    String? initials,
    Grade? grades,
    int? averageGrade,
  }) {
    return Instituto(
      id: id ?? this.id,
      name: name ?? this.name,
      initials: initials ?? this.initials,
      grades: grades ?? this.grades,
      averageGrade: averageGrade ?? this.averageGrade,
    );
  }
}
