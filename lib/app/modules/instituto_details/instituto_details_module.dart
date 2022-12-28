import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_details_bloc.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/controllers/instituto_details_controller.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/pages/instituto_details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InstitutoDetailsModule extends Module {
  static const String routeName = '/institutoDetails/';

  @override
  List<Bind> get binds => [
        Bind((i) => InstitutoDetailsBloc()),
        Bind(
          (i) => InstitutoDetailsController(
            getInstitutoDetailsUsecase: i(),
            bloc: i(),
            id: i.args.data['id'],
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => InstitutoDetailsPage(),
        )
      ];
}
