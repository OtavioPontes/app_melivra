import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_response.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_usecase.dart';
import 'package:app_melivra/app/modules/search/presentation/bloc/search_professor_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../institutos/domain/entities/institutos_response.dart';
import '../../../professores/domain/entities/professor_entity.dart';
import '../bloc/search_institutes_bloc.dart';

class SearchController {
  final GetInstitutosUsecase _getInstitutosUsecase;
  final GetProfessorsUsecase _getProfessorsUsecase;
  final SearchProfessorsBloc searchProfessorsBloc;
  final SearchInstitutesBloc searchInstitutesBloc;

  TextEditingController searchController = TextEditingController();
  InstitutosResponse? institutoResponse;
  ProfessorResponse? professorResponse;
  int page = 1;
  List<Professor> professors = [];
  List<Instituto> institutes = [];

  SearchController({
    required this.searchProfessorsBloc,
    required this.searchInstitutesBloc,
    required GetInstitutosUsecase getInstitutosUsecase,
    required GetProfessorsUsecase getProfessorsUsecase,
  })  : _getInstitutosUsecase = getInstitutosUsecase,
        _getProfessorsUsecase = getProfessorsUsecase;

  Future<void> getInstitutos() async {
    final result = await _getInstitutosUsecase(
      ParamsGetInstitutosUsecase(
        searchText: searchController.text,
      ),
    );

    result.fold(
      (failure) {
        searchInstitutesBloc.add(
          SearchInstitutesFailureEvent(message: failure.message),
        );
      },
      (response) {
        institutoResponse = response;
        institutes.addAll(response.institutos);
        institutes = institutes.toSet().toList();
        searchInstitutesBloc.add(
          SearchInstitutesSuccessEvent(institutes: institutes),
        );
      },
    );
  }

  void setNextPage() => page = page + 1;

  void dispose() {
    page = 1;
    resetLists();
    searchProfessorsBloc.add(
      SearchProfessorsResetEvent(),
    );
    searchInstitutesBloc.add(
      SearchInstitutesResetEvent(),
    );
  }

  void resetLists() {
    professors.clear();
    institutes.clear();
  }

  Future<void> getProfessores() async {
    final result = await _getProfessorsUsecase(
      ParamsGetProfessorsUsecase(
        page: page,
        searchText: searchController.text,
      ),
    );

    result.fold(
      (failure) {
        searchProfessorsBloc.add(
          SearchProfessorsFailureEvent(message: failure.message),
        );
      },
      (response) {
        professorResponse = response;
        professors.addAll(response.professors);
        professors = professors.toSet().toList();
        searchProfessorsBloc.add(
          SearchProfessorsSuccessEvent(professors: professors),
        );
      },
    );
  }
}
