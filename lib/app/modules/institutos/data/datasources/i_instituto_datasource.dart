import 'package:app_melivra/app/modules/institutos/data/models/instituto_model.dart';

import '../../../ranking_institutos/domain/entities/ranking_config_entity.dart';
import '../../domain/entities/institutos_response.dart';

abstract class IInstitutoDatasource {
  Future<InstitutosResponse> getInstitutos([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]);

  Future<RankingConfig> getInstitutosRank([
    int? page,
    int? itemsPerPage,
  ]);

  Future<InstitutoModel> getInstitutoDetails({required int id});
}
