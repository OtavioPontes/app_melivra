import 'package:app_melivra/app/modules/suggestions/data/services/send_suggestion_service.dart';
import 'package:app_melivra/app/modules/suggestions/presentation/controllers/suggestions_controller.dart';
import 'package:app_melivra/app/modules/suggestions/presentation/pages/suggestions_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SuggestionModule extends Module {
  static const routeName = '/suggestions/';
  @override
  List<Bind> get binds => [
        Bind((i) => SendSuggestionService(dio: i())),
        Bind((i) => SuggestionsController(sendSuggestionService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const SuggestionsPage(),
        )
      ];
}
