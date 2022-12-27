import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/top_institutos_bloc.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_rank_usecase.dart';

class HomeController {
  final GetInstitutosRankUsecase _getInstitutosRankUsecase;
  final UserStore store;
  final TopInstitutosBloc bloc;

  HomeController({
    required GetInstitutosRankUsecase getInstitutosRankUsecase,
    required this.store,
    required this.bloc,
  }) : _getInstitutosRankUsecase = getInstitutosRankUsecase {
    pipeline();
  }

  pipeline() async {
    getListInstitutes();
  }

  Future<void> getListInstitutes() async {
    final result = await _getInstitutosRankUsecase(
      ParamsGetInstitutosRankUsecase(itemsPerPage: 3),
    );
    result.fold(
      (failure) {
        bloc.add(
          TopInstitutosFailureEvent(message: failure.message),
        );
      },
      (institutos) {
        bloc.add(
          TopInstitutosSuccessEvent(
            rankInstitutes: institutos,
          ),
        );
      },
    );
  }
}
