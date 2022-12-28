import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:dio/dio.dart';

import 'package:app_melivra/app/modules/professores/data/datasources/i_professor_datasource.dart';
import 'package:app_melivra/app/modules/professores/data/model/professor_model.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_response.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/ranking_professors_config.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/endpoints.dart';

class ProfessorsDatasource implements IProfessorDatasource {
  final Dio _dio;
  ProfessorsDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<ProfessorModel> getProfessorDetails({required int id}) async {
    try {
      final response = await _dio.get(
        "${Endpoints.professors}$id",
      );
      return ProfessorModel.fromMap(response.data);
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ProfessorResponse> getProfessors(
      [int? page, int? itemsPerPage, String? searchText]) async {
    try {
      final response = await _dio.get(
        Endpoints.professors,
        queryParameters: {
          'page': page,
          'items_per_page': itemsPerPage,
          'q': searchText,
        },
      );
      final List<Professor> professors = List.from(
        response.data['data']
            .map(
              (item) => ProfessorModel.fromMap(item).toEntity(),
            )
            .toList(),
      );
      return ProfessorResponse(
        totalItems: response.data['total_items'],
        totalPages: response.data['total_pages'],
        itemsPerPage: response.data['items_per_page'],
        professors: professors,
      );
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<RankingProfessorsConfig> getProfessorsRank(
      [int? page, int? itemsPerPage]) async {
    try {
      final response = await _dio.get(
        Endpoints.professorsRank,
        queryParameters: {
          if (page != null) 'page': page,
          'items_per_page': itemsPerPage,
        },
      );
      final List<Professor> professors = List.from(
        response.data['data']
            .map(
              (item) => ProfessorModel.fromMap(item).toEntity(),
            )
            .toList(),
      );
      return RankingProfessorsConfig(
        totalItems: response.data['total_items'],
        totalPages: response.data['total_pages'],
        itemsPerPage: response.data['items_per_page'],
        professors: professors,
      );
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode,
      );
    }
  }
}
