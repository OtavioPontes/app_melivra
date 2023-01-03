import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/core/domain/entities/grades_response_config.dart';
import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_response.dart';
import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores/domain/repositories/i_professor_repository.dart';

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
  Future<Either<IFailure, ProfessorResponse>> getProfessors({
    int? page,
    int? itemsPerPage,
    String? searchText,
    int? instituteId,
  }) async {
    try {
      final response = await _datasource.getProfessors(
        page: page,
        itemsPerPage: itemsPerPage,
        searchText: searchText,
        instituteId: instituteId,
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
  Future<Either<IFailure, RankingProfessorsConfig>> getProfessorsRank({
    int? page,
    int? itemsPerPage,
  }) async {
    try {
      final rankingConfig = await _datasource.getProfessorsRank(
        page: page,
        itemsPerPage: itemsPerPage,
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

  @override
  Future<Either<IFailure, void>> evaluateProfessor({
    required int id,
    required Grade grade,
  }) async {
    try {
      await _datasource.evaluateProfessor(
        grade: grade,
        id: id,
      );
      return Right(
        voidRight,
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<IFailure, GradesResponseConfig>> getProfessorGrades(
      {required int id}) async {
    try {
      final GradesResponseConfig gradesConfig =
          await _datasource.getProfessorGrades(
        id: id,
      );
      return Right(
        gradesConfig,
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<IFailure, void>> updateProfessorGrade(
      {required int id, required String description}) async {
    try {
      await _datasource.updateGrade(id: id, description: description);
      return Right(voidRight);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    }
  }
}
