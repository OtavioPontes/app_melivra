import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_details_bloc.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_professors_bloc.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_instituto_details.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_response.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_usecase.dart';

import '../../../professores/domain/entities/professor_entity.dart';

class InstitutoDetailsController {
  final GetInstitutoDetailsUsecase _getInstitutoDetailsUsecase;
  final GetProfessorsUsecase _getProfessorsUsecase;
  final InstitutoDetailsBloc bloc;
  final InstitutoProfessorsBloc professorsBloc;
  final int id;

  int page = 1;
  String? searchText;
  ProfessorResponse? response;
  List<Professor> professors = [];

  InstitutoDetailsController({
    required GetInstitutoDetailsUsecase getInstitutoDetailsUsecase,
    required GetProfessorsUsecase getProfessorsUsecase,
    required this.bloc,
    required this.professorsBloc,
    required this.id,
  })  : _getInstitutoDetailsUsecase = getInstitutoDetailsUsecase,
        _getProfessorsUsecase = getProfessorsUsecase {
    pipeline();
  }

  Future<void> pipeline() async {
    await getInstitutoDetails();
    await getProfessoresByInstituto();
  }

  void setNextPage() => page = page + 1;

  Future<void> getProfessoresByInstituto() async {
    if (professors.isEmpty) {
      professorsBloc.add(
        InstitutoProfessorsLoadingEvent(),
      );
    }
    final result = await _getProfessorsUsecase(
      ParamsGetProfessorsUsecase(
        instituteId: id,
        page: page,
        searchText: searchText,
      ),
    );
    result.fold(
      (failure) {
        professorsBloc.add(
          InstitutoProfessorsFailureEvent(
            message: failure.message,
          ),
        );
      },
      (response) {
        this.response = response;
        professors = (response.professors);
        professorsBloc.add(
          InstitutoProfessorsSuccessEvent(
            professor: professors,
          ),
        );
      },
    );
  }

  Future<void> getInstitutoDetails() async {
    bloc.add(
      InstitutoDetailsLoadingEvent(),
    );
    final result = await _getInstitutoDetailsUsecase(
      ParamsGetInstitutoDetailsUsecase(id: id),
    );
    result.fold(
      (failure) {
        bloc.add(
          InstitutoDetailsFailureEvent(message: failure.message),
        );
      },
      (instituto) {
        return bloc.add(
          InstitutoDetailsSuccessEvent(institute: instituto),
        );
      },
    );
  }
}
