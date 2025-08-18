import 'package:app_melivra/app/core/core_module.dart';
import 'package:app_melivra/app/modules/suggestions/data/services/send_suggestion_service.dart';
import 'package:app_melivra/app/modules/suggestions/domain/services/i_send_suggestion_service.dart';
import 'package:app_melivra/app/modules/suggestions/presentation/controllers/suggestions_controller.dart';
import 'package:app_melivra/app/modules/suggestions/presentation/pages/suggestions_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SuggestionModule extends Module {
  static const String routeName = '/suggestions/';
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.add<ISendSuggestionService>(() => SendSuggestionService(dio: i()));
    i.add(() => SuggestionsController(sendSuggestionService: i()));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const SuggestionsPage(),
    );
  }
}
