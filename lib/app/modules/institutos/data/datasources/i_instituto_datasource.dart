import 'package:app_melivra/app/modules/institutos/data/models/instituto_model.dart';

abstract class IInstitutoDatasource {
  Future<List<InstitutoModel>> getInstitutos([
    int? page,
    int? itemsPerPage,
    String? searchText,
  ]);

  Future<List<InstitutoModel>> getInstitutosRank([
    int? page,
    int? itemsPerPage,
  ]);

  Future<InstitutoModel> getInstitutoDetails({required int id});
}
