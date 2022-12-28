import '../../domain/entities/professor_response.dart';
import '../../domain/usecases/get_professors_usecase.dart';
import '../bloc/professors_bloc.dart';

class ProfessorsController {
  final GetProfessorsUsecase _getProfessorsUsecase;
  final ProfessorsBloc bloc;

  ProfessorResponse? response;

  ProfessorsController({
    required GetProfessorsUsecase getProfessorsUsecase,
    required this.bloc,
  }) : _getProfessorsUsecase = getProfessorsUsecase {
    pipeline();
  }

  void pipeline() async {
    await getProfessors();
  }

  Future<void> getProfessors() async {
    final result = await _getProfessorsUsecase(
      ParamsGetProfessorsUsecase(),
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
