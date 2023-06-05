import 'package:app_melivra/app/core/domain/entities/grades_response_config.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/grade.dart';
import '../../../../core/error/failures.dart';
import '../entities/professor_response.dart';
import '../entities/ranking_professors_config.dart';

abstract class IProfessorRepository {
  Future<Either<IFailure, ProfessorResponse>> getProfessors({
    int? page,
    int? itemsPerPage,
    String? searchText,
    int? instituteId,
  });

  Future<Either<IFailure, RankingProfessorsConfig>> getProfessorsRank({
    int? page,
    int? itemsPerPage,
  });

  Future<Either<IFailure, Professor>> getProfessorDetails({required int id});

  Future<Either<IFailure, void>> evaluateProfessor({
    required int id,
    required Grade grade,
  });

  Future<Either<IFailure, void>> evaluateComment({
    required int id,
    required bool isLike,
  });

  Future<Either<IFailure, GradesResponseConfig>> getProfessorGrades({
    required int id,
  });

  Future<Either<IFailure, int>> getProfessorGradesCount({
    required int id,
  });

  Future<Either<IFailure, void>> updateProfessorGrade({
    required int id,
    required String description,
  });
  Future<Either<IFailure, Grade>> getGlobalGrades();
}
