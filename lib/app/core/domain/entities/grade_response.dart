import 'dart:convert';

import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:equatable/equatable.dart';

class GradeResponse extends Equatable {
  final int id;
  final String description;
  final Grade grade;
  final int averageGrade;
  final DateTime date;
  final String userName;
  final int likes;
  final int dislikes;

  const GradeResponse({
    required this.id,
    required this.description,
    required this.grade,
    required this.averageGrade,
    required this.date,
    required this.userName,
    required this.likes,
    required this.dislikes,
  });

  @override
  List<Object> get props {
    return [
      id,
      description,
      grade,
      averageGrade,
      date,
      userName,
    ];
  }

  GradeResponse copyWith({
    int? id,
    String? description,
    Grade? grade,
    int? averageGrade,
    DateTime? date,
    String? userName,
    int? likes,
    int? dislikes,
  }) {
    return GradeResponse(
      id: id ?? this.id,
      description: description ?? this.description,
      grade: grade ?? this.grade,
      averageGrade: averageGrade ?? this.averageGrade,
      date: date ?? this.date,
      userName: userName ?? this.userName,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'grade': grade.toMap(),
      'averageGrade': averageGrade,
      'date': date.millisecondsSinceEpoch,
      'userName': userName,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  factory GradeResponse.fromMap(Map<String, dynamic> map) {
    return GradeResponse(
      id: map['id']?.toInt() ?? 0,
      description: map['description'] ?? '',
      grade: Grade.fromMap(map),
      averageGrade: map['total_grade']?.toInt() ?? 0,
      date: DateTime.parse(map['created_at']),
      userName: map['user'] ?? '',
      likes: map['likes'] ?? 0,
      dislikes: map['dislikes'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GradeResponse.fromJson(String source) =>
      GradeResponse.fromMap(json.decode(source));
}
