import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/ranking_professors_config.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_global_grade_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_rank_usecase.dart';
import 'package:app_melivra/app/modules/professores/presentation/bloc/global_grade_bloc.dart';

import '../bloc/professors_bloc.dart';

class ProfessorsController {
  final GetProfessorsRankUsecase _getProfessorsUsecase;
  final GetGlobalGradeUsecase _getGlobalGradeUsecase;
  final ProfessorsBloc bloc;
  final GlobalGradeBloc globalGradeBloc;

  RankingProfessorsConfig? response;

  ProfessorsController({
    required GetGlobalGradeUsecase getGlobalGradeUsecase,
    required GetProfessorsRankUsecase getProfessorsUsecase,
    required this.bloc,
    required this.globalGradeBloc,
  })  : _getProfessorsUsecase = getProfessorsUsecase,
        _getGlobalGradeUsecase = getGlobalGradeUsecase {
    pipeline();
  }

  Future<void> pipeline() async {
    await getProfessors();
    await getGlobalGrade();
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

  Future<void> getGlobalGrade() async {
    final result = await _getGlobalGradeUsecase(const NoParams());

    result.fold(
      (failure) {
        globalGradeBloc.add(
          GlobalGradeFailureEvent(message: failure.message),
        );
      },
      (grade) {
        return globalGradeBloc.add(
          GlobalGradeSuccessEvent(grade: grade),
        );
      },
    );
  }
}
