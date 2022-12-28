import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/network/endpoints.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:app_melivra/app/modules/ranking_institutos/domain/entities/ranking_config_entity.dart';
import 'package:dio/dio.dart';

import 'package:app_melivra/app/modules/institutos/data/datasources/i_instituto_datasource.dart';
import 'package:app_melivra/app/modules/institutos/data/models/instituto_model.dart';

import '../../domain/entities/institutos_response.dart';

class InstitutoDatasource implements IInstitutoDatasource {
  final Dio _dio;
  InstitutoDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<InstitutoModel> getInstitutoDetails({required int id}) async {
    try {
      final response = await _dio.get(
        Endpoints.institutosRank,
        queryParameters: {
          'q': id,
        },
      );
      return InstitutoModel.fromMap(response.data);
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<InstitutosResponse> getInstitutos([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]) async {
    try {
      final response = await _dio.get(
        Endpoints.institutos,
        queryParameters: {
          'page': page,
          'items_per_page': itemsPerPage,
          'q': searchText,
        },
      );
      final List<Instituto> institutos = List.from(
        response.data['data']
            .map(
              (item) => InstitutoModel.fromMap(item).toEntity(),
            )
            .toList(),
      );
      return InstitutosResponse(
        totalItems: response.data['total_items'],
        totalPages: response.data['total_pages'],
        itemsPerPage: response.data['items_per_page'],
        institutos: institutos,
      );
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<RankingConfig> getInstitutosRank([
    int? page,
    int? itemsPerPage,
  ]) async {
    try {
      final response = await _dio.get(
        Endpoints.institutosRank,
        queryParameters: {
          if (page != null) 'page': page,
          'items_per_page': itemsPerPage,
        },
      );
      final List<Instituto> institutos = List.from(
        response.data['data']
            .map(
              (item) => InstitutoModel.fromMap(item).toEntity(),
            )
            .toList(),
      );
      return RankingConfig(
        totalItems: response.data['total_items'],
        totalPages: response.data['total_pages'],
        itemsPerPage: response.data['items_per_page'],
        institutos: institutos,
      );
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode,
      );
    }
  }
}
