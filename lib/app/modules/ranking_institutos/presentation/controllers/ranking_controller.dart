import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_rank_usecase.dart';
import 'package:app_melivra/app/modules/ranking_institutos/domain/entities/ranking_config_entity.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/bloc/ranking_bloc.dart';

class RankController {
  final GetInstitutosRankUsecase _getInstitutosRankUsecase;
  final RankingBloc bloc;

  int page = 1;
  RankingConfig? config;

  RankController({
    required this.bloc,
    required GetInstitutosRankUsecase getInstitutosRankUsecase,
  }) : _getInstitutosRankUsecase = getInstitutosRankUsecase {
    pipeline();
  }

  Future<void> pipeline() async {
    await getInstitutos();
  }

  Future<void> getInstitutos() async {
    bloc.add(RankingLoadingEvent());
    final result = await _getInstitutosRankUsecase(
      ParamsGetInstitutosRankUsecase(
        page: page,
      ),
    );

    result.fold(
      (failure) {
        bloc.add(
          RankingFailureEvent(message: failure.message),
        );
      },
      (rankConfig) {
        config = rankConfig;
        return bloc.add(
          RankingSuccessEvent(
            rankInstitutes: rankConfig.institutos,
          ),
        );
      },
    );
  }
}
