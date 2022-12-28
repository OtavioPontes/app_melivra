import '../../../professores/domain/usecases/get_professor_details_usecase.dart';
import '../bloc/professor_details_bloc.dart';

class ProfessorDetailsController {
  final GetProfessorDetailsUsecase _getProfessorDetailsUsecase;
  final ProfessorDetailsBloc bloc;
  final int id;
  ProfessorDetailsController({
    required GetProfessorDetailsUsecase getProfessorDetailsUsecase,
    required this.bloc,
    required this.id,
  }) : _getProfessorDetailsUsecase = getProfessorDetailsUsecase {
    pipeline();
  }

  pipeline() async {
    await getProfessorDetails(id: id);
  }

  Future<void> getProfessorDetails({required int id}) async {
    final result = await _getProfessorDetailsUsecase(
      ParamsGetProfessorDetailsUsecase(id: id),
    );
    result.fold(
      (failure) {
        bloc.add(
          ProfessorDetailsFailureEvent(message: failure.message),
        );
      },
      (professor) {
        return bloc.add(
          ProfessorDetailsSuccessEvent(professor: professor),
        );
      },
    );
  }
}
