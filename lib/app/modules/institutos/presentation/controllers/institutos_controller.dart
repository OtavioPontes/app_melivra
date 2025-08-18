import 'package:app_melivra/app/modules/institutos/domain/entities/institutos_response.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_usecase.dart';

import '../../../../core/domain/usecases/i_usecase.dart';
import '../../../professores/domain/usecases/get_global_grade_usecase.dart';
import '../../../professores/presentation/bloc/global_grade_bloc.dart';
import '../bloc/institutos_bloc.dart';

class InstitutosController {
  final GetInstitutosUsecase _getInstitutosUsecase;
  final InstitutosBloc bloc;
  final GetGlobalGradeUsecase _getGlobalGradeUsecase;
  final GlobalGradeBloc globalGradeBloc;

  InstitutosResponse? response;

  InstitutosController({
    required GetGlobalGradeUsecase getGlobalGradeUsecase,
    required this.globalGradeBloc,
    required GetInstitutosUsecase getInstitutosUsecase,
    required this.bloc,
  })  : _getInstitutosUsecase = getInstitutosUsecase,
        _getGlobalGradeUsecase = getGlobalGradeUsecase {
    pipeline();
  }

  Future<void> pipeline() async {
    await getInstitutos();
  }

  Future<void> getInstitutos() async {
    bloc.add(InstitutosLoadingEvent());
    final result = await _getInstitutosUsecase(
      ParamsGetInstitutosUsecase(),
    );

    result.fold(
      (failure) {
        bloc.add(
          InstitutosFailureEvent(message: failure.message),
        );
      },
      (response) {
        this.response = response;
        return bloc.add(
          InstitutosSuccessEvent(
            institutes: response.institutos,
          ),
        );
      },
    );
  }

  Future<void> getGlobalGrade() async {
    globalGradeBloc.add(GlobalGradeLoadingEvent());
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
