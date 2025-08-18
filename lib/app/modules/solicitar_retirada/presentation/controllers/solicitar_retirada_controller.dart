import 'package:app_melivra/app/modules/professores/domain/entities/professor_response.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_usecase.dart';
import 'package:app_melivra/app/modules/search/presentation/bloc/search_professor_bloc.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/domain/services/i_send_solicitacao_retirada_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../professores/domain/entities/professor_entity.dart';

class SolicitarRetiradaController {
  final GetProfessorsUsecase _getProfessorsUsecase;
  final SearchProfessorsBloc searchProfessorsBloc;
  final ISendSolicitacaoRetiradaService _sendSolicitacaoRetiradaService;

  TextEditingController searchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ProfessorResponse? professorResponse;
  Professor? selectedProfessor;
  int page = 1;

  final List<Professor> professors = [];

  SolicitarRetiradaController({
    required this.searchProfessorsBloc,
    required GetProfessorsUsecase getProfessorsUsecase,
    required ISendSolicitacaoRetiradaService sendSolicitacaoRetiradaService,
  })  : _getProfessorsUsecase = getProfessorsUsecase,
        _sendSolicitacaoRetiradaService = sendSolicitacaoRetiradaService;

  void setNextPage() => page = page + 1;

  void dispose() {
    page = 1;
    resetLists();
    searchController.clear();
    searchProfessorsBloc.add(
      SearchProfessorsResetEvent(),
    );
  }

  void resetLists() {
    professors.clear();
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
        searchProfessorsBloc.add(
          SearchProfessorsSuccessEvent(professors: professors),
        );
      },
    );
  }

  Future<void> sendExclusionRequest() async {
    final result = await _sendSolicitacaoRetiradaService(
      description: descriptionController.text,
      id: selectedProfessor!.id,
    );

    await result.fold(
      (failure) async => Fluttertoast.showToast(
        msg: failure.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.black,
        fontSize: 12,
      ),
      (success) async {
        descriptionController.clear();
        selectedProfessor = null;
        return Fluttertoast.showToast(
          msg: "Solicitação enviada com sucesso ✅",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 12,
        );
      },
    );
  }
}
