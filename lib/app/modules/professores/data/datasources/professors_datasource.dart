import 'package:app_melivra/app/core/domain/entities/grade.dart';
import 'package:app_melivra/app/core/domain/entities/grades_response_config.dart';
import 'package:app_melivra/app/modules/professores/data/datasources/i_professor_datasource.dart';
import 'package:app_melivra/app/modules/professores/data/model/professor_model.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_response.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/ranking_professors_config.dart';
import 'package:dio/dio.dart';

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
  Future<ProfessorResponse> getProfessors({
    int? page,
    int? itemsPerPage,
    String? searchText,
    int? instituteId,
  }) async {
    try {
      final response = await _dio.get(
        Endpoints.professors,
        queryParameters: {
          if (page != null) 'page': page,
          if (itemsPerPage != null) 'items_per_page': itemsPerPage,
          if (searchText != null) 'q': searchText,
          if (instituteId != null) 'institute_id': instituteId
        },
      );
      final professors = List<Professor>.from(
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
      {int? page, int? itemsPerPage,}) async {
    try {
      final response = await _dio.get(
        Endpoints.professorsRank,
        queryParameters: {
          if (page != null) 'page': page,
          'items_per_page': itemsPerPage,
        },
      );
      final professors = List<Professor>.from(
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

  @override
  Future<void> evaluateProfessor({
    required int id,
    required Grade grade,
  }) async {
    try {
      await _dio.post(
        Endpoints.evaluateProfessor(id: id),
        data: grade.toJson(),
      );
    } on DioError catch (e) {
      throw ServerException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<GradesResponseConfig> getProfessorGrades({required int id}) async {
    try {
      final response = await _dio.get(
        Endpoints.evaluateProfessor(id: id),
      );
      return GradesResponseConfig.fromMap(response.data);
    } on DioError catch (e) {
      throw ServerException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> updateGrade({
    required int id,
    required String description,
  }) async {
    try {
      await _dio.put(
        Endpoints.evaluateProfessor(id: id),
        data: {'description': description},
      );
    } on DioError catch (e) {
      throw ServerException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<Grade> getGlobalGrades() async {
    try {
      final response = await _dio.get(
        Endpoints.globalGrades,
      );
      return Grade.fromMap(response.data);
    } on DioError catch (e) {
      throw ServerException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    }
  }
}
