import 'dart:convert';

import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/top_institutos_bloc.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/ultimos_pesquisados_bloc.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_rank_usecase.dart';
import 'package:app_melivra/app/modules/professores/data/model/professor_model.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professor_details_usecase.dart';
import 'package:app_melivra/app/modules/professores/domain/usecases/get_professors_usecase.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController {
  final GetInstitutosRankUsecase _getInstitutosRankUsecase;
  final GetProfessorDetailsUsecase _getProfessorDetailsUsecase;
  final UserStore store;
  final Box box;
  final TopInstitutosBloc topInstitutosBloc;
  final UltimosPesquisadosBloc ultimosPesquisadosBloc;

  HomeController({
    required GetProfessorDetailsUsecase getProfessorDetailsUsecase,
    required GetInstitutosRankUsecase getInstitutosRankUsecase,
    required this.store,
    required this.topInstitutosBloc,
    required this.ultimosPesquisadosBloc,
    required this.box,
  })  : _getInstitutosRankUsecase = getInstitutosRankUsecase,
        _getProfessorDetailsUsecase = getProfessorDetailsUsecase {
    pipeline();
  }

  pipeline() async {
    getListInstitutes();
    getLastProfessors();
  }

  Future<void> getLastProfessors() async {
    ultimosPesquisadosBloc.add(UltimosPesquisadosLoadingEvent());
    final rawData = await Hive.box('melivra').get('lastProfessors');
    final decodedData = rawData != null ? jsonDecode(rawData) : null;

    List<Professor> professors = [];
    if (decodedData != null) {
      professors = List<Professor>.generate(
        decodedData.length,
        (index) => ProfessorModel.fromJson(
          decodedData[index],
        ).toEntity(),
      );
    }
    if (professors.isEmpty) {
      ultimosPesquisadosBloc.add(
        UltimosPesquisadosEmptyEvent(),
      );
      return;
    }
    List<Professor> listFromServer = [];
    for (Professor professor in professors) {
      Professor? item = await getProfessor(id: professor.id);
      if (item != null) {
        listFromServer.add(item);
      }
    }
    ultimosPesquisadosBloc.add(
      UltimosPesquisadosSuccessEvent(professors: listFromServer),
    );
  }

  Future<Professor?> getProfessor({required int id}) async {
    final result = await _getProfessorDetailsUsecase(
      ParamsGetProfessorDetailsUsecase(id: id),
    );
    return result.fold(
      (failure) => null,
      (professor) => professor,
    );
  }

  Future<void> getListInstitutes() async {
    final result = await _getInstitutosRankUsecase(
      ParamsGetInstitutosRankUsecase(itemsPerPage: 3),
    );
    result.fold(
      (failure) {
        topInstitutosBloc.add(
          TopInstitutosFailureEvent(message: failure.message),
        );
      },
      (rankConfig) {
        topInstitutosBloc.add(
          TopInstitutosSuccessEvent(
            rankInstitutes: rankConfig.institutos,
          ),
        );
      },
    );
  }
}
