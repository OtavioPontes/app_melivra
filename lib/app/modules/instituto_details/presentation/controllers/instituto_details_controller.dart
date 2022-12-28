import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_details_bloc.dart';
import 'package:app_melivra/app/modules/institutos/domain/usecases/get_instituto_details.dart';

class InstitutoDetailsController {
  final GetInstitutoDetailsUsecase _getInstitutoDetailsUsecase;
  final InstitutoDetailsBloc bloc;
  final int id;
  InstitutoDetailsController({
    required GetInstitutoDetailsUsecase getInstitutoDetailsUsecase,
    required this.bloc,
    required this.id,
  }) : _getInstitutoDetailsUsecase = getInstitutoDetailsUsecase {
    pipeline();
  }

  pipeline() async {
    await getInstitutoDetails(id: id);
  }

  Future<void> getInstitutoDetails({required int id}) async {
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
