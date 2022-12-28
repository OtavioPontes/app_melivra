import 'package:app_melivra/app/modules/institutos/presentation/bloc/institutos_bloc.dart';
import 'package:app_melivra/app/modules/institutos/presentation/controllers/institutos_controller.dart';
import 'package:app_melivra/app/modules/institutos/presentation/pages/institutos_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InstitutosModule extends Module {
  static const String routeName = '/institutos/';
  static ModularProvider provider = ModularProvider(
    module: InstitutosModule(),
    child: InstitutosPage(),
  );

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => InstitutosPage(),
        ),
      ];
}
