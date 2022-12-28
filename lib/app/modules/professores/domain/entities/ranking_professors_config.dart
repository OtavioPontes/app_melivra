import 'dart:convert';

import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/professor_model.dart';

class RankingProfessorsConfig extends Equatable {
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;
  final List<Professor> professors;

  const RankingProfessorsConfig({
    required this.totalItems,
    required this.totalPages,
    required this.itemsPerPage,
    required this.professors,
  });
  @override
  List<Object> get props => [
        totalItems,
        totalPages,
        itemsPerPage,
        professors,
      ];

  RankingProfessorsConfig copyWith({
    int? totalItems,
    int? totalPages,
    int? itemsPerPage,
    List<Professor>? professors,
  }) {
    return RankingProfessorsConfig(
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      professors: professors ?? this.professors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalItems': totalItems,
      'totalPages': totalPages,
      'itemsPerPage': itemsPerPage,
      'professors':
          professors.map((x) => ProfessorModel.fromEntity(x).toMap()).toList(),
    };
  }

  factory RankingProfessorsConfig.fromMap(Map<String, dynamic> map) {
    return RankingProfessorsConfig(
      totalItems: map['totalItems']?.toInt() ?? 0,
      totalPages: map['totalPages']?.toInt() ?? 0,
      itemsPerPage: map['itemsPerPage']?.toInt() ?? 0,
      professors: List<Professor>.from(
        map['professors']?.map(
          (x) => ProfessorModel.fromMap(x).toEntity(),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RankingProfessorsConfig.fromJson(String source) =>
      RankingProfessorsConfig.fromMap(json.decode(source));
}
