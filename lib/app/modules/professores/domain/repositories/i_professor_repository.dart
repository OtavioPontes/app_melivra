import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/professor_response.dart';
import '../entities/ranking_professors_config.dart';

abstract class IProfessorRepository {
  Future<Either<IFailure, ProfessorResponse>> getProfessors([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]);

  Future<Either<IFailure, RankingProfessorsConfig>> getProfessorsRank([
    int? page,
    int? itemsPerPage,
  ]);

  Future<Either<IFailure, Professor>> getProfessorDetails({required int id});
}
