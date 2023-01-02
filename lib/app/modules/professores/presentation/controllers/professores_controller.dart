import 'package:app_melivra/app/modules/professores/domain/entities/ranking_professors_config.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_rank_usecase.dart';

import '../bloc/professors_bloc.dart';

class ProfessorsController {
  final GetProfessorsRankUsecase _getProfessorsUsecase;
  final ProfessorsBloc bloc;

  RankingProfessorsConfig? response;

  ProfessorsController({
    required GetProfessorsRankUsecase getProfessorsUsecase,
    required this.bloc,
  }) : _getProfessorsUsecase = getProfessorsUsecase {
    pipeline();
  }

  void pipeline() async {
    await getProfessors();
  }

  Future<void> getProfessors() async {
    final result = await _getProfessorsUsecase(
      ParamsGetProfessorsRankUsecase(),
    );

    result.fold(
      (failure) {
        bloc.add(
          ProfessorsFailureEvent(message: failure.message),
        );
      },
      (response) {
        this.response = response;
        return bloc.add(
          ProfessorsSuccessEvent(
            professors: response.professors,
          ),
        );
      },
    );
  }
}
