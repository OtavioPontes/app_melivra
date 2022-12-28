import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/institutos_response.dart';
import 'package:dartz/dartz.dart';

import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/institutos/data/datasources/i_instituto_datasource.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:app_melivra/app/modules/institutos/domain/repositories/i_instituto_repository.dart';

import '../../../ranking_institutos/domain/entities/ranking_config_entity.dart';

class InstitutoRepository implements IInstitutoRepository {
  final IInstitutoDatasource _datasource;
  InstitutoRepository({
    required IInstitutoDatasource datasource,
  }) : _datasource = datasource;
  @override
  Future<Either<IFailure, Instituto>> getInstitutoDetails(
      {required int id}) async {
    try {
      final model = await _datasource.getInstitutoDetails(id: id);
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
  Future<Either<IFailure, InstitutosResponse>> getInstitutos([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]) async {
    try {
      final response = await _datasource.getInstitutos(
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
  Future<Either<IFailure, RankingConfig>> getInstitutosRank([
    int? page,
    int? itemsPerPage,
  ]) async {
    try {
      final rankingConfig = await _datasource.getInstitutosRank(
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
