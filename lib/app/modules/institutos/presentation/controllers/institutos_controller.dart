import 'package:app_melivra/app/modules/institutos/domain/entities/institutos_response.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_institutos_usecase.dart';

import '../bloc/institutos_bloc.dart';

class InstitutosController {
  final GetInstitutosUsecase _getInstitutosUsecase;
  final InstitutosBloc bloc;

  InstitutosResponse? response;

  InstitutosController({
    required GetInstitutosUsecase getInstitutosUsecase,
    required this.bloc,
  }) : _getInstitutosUsecase = getInstitutosUsecase {
    pipeline();
  }

  void pipeline() async {
    await getInstitutos();
  }

  Future<void> getInstitutos() async {
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
}
