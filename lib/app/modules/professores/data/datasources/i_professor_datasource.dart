import '../../domain/entities/professor_response.dart';
import '../../domain/entities/ranking_professors_config.dart';
import '../model/professor_model.dart';

abstract class IProfessorDatasource {
  Future<ProfessorResponse> getProfessors([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]);

  Future<RankingProfessorsConfig> getProfessorsRank([
    int? page,
    int? itemsPerPage,
  ]);

  Future<ProfessorModel> getProfessorDetails({required int id});
}
