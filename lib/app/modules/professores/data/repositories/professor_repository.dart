import 'package:app_melivra/app/modules/professores/domain/entities/professor_response.dart';
import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/institutos_response.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores/domain/repositories/i_professor_repository.dart';
import 'package:app_melivra/app/modules/ranking_institutos/domain/entities/ranking_config_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/ranking_professors_config.dart';
import '../datasources/i_professor_datasource.dart';

class ProfessorRepository implements IProfessorRepository {
  final IProfessorDatasource _datasource;
  ProfessorRepository({
    required IProfessorDatasource datasource,
  }) : _datasource = datasource;
  @override
  Future<Either<IFailure, Professor>> getProfessorDetails(
      {required int id}) async {
    try {
      final model = await _datasource.getProfessorDetails(id: id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<IFailure, ProfessorResponse>> getProfessors(
      [int? page, int? itemsPerPage, String? searchText]) async {
    try {
      final response = await _datasource.getProfessors(
        page,
        itemsPerPage,
        searchText,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<IFailure, RankingProfessorsConfig>> getProfessorsRank(
      [int? page, int? itemsPerPage]) async {
    try {
      final rankingConfig = await _datasource.getProfessorsRank(
        page,
        itemsPerPage,
      );
      return Right(
        rankingConfig,
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    }
  }
}
