import 'package:app_melivra/app/core/domain/entities/grades_response_config.dart';

import '../../../../core/domain/entities/grade.dart';
import '../../domain/entities/professor_response.dart';
import '../../domain/entities/ranking_professors_config.dart';
import '../model/professor_model.dart';

abstract class IProfessorDatasource {
  Future<ProfessorResponse> getProfessors({
    int? page,
    int? itemsPerPage,
    String? searchText,
    int? instituteId,
  });

  Future<RankingProfessorsConfig> getProfessorsRank({
    int? page,
    int? itemsPerPage,
  });

  Future<ProfessorModel> getProfessorDetails({required int id});

  Future<void> evaluateProfessor({
    required int id,
    required Grade grade,
  });

  Future<void> evaluateGradeComment({
    required int id,
    required bool isLike,
  });

  Future<GradesResponseConfig> getProfessorGrades({
    required int id,
  });

  Future<int> getProfessorGradesCount({
    required int id,
  });

  Future<void> updateGrade({
    required int id,
    required String description,
  });

  Future<Grade> getGlobalGrades();

  Future<Grade?> getProfessorGradesByUser({required int id});
}
