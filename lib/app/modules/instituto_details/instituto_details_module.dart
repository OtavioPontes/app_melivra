import 'package:app_melivra/app/modules/instituto_details/presentation/pages/instituto_details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InstitutoDetailsModule extends Module {
  static const String routeName = '/institutoDetails/';

  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const InstitutoDetailsPage(),
        )
      ];
}
