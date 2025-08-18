import 'package:app_melivra/app/modules/about_us/about_us_module.dart';
import 'package:app_melivra/app/modules/bottom_navigation/bottom_navigation_module.dart';
import 'package:app_melivra/app/modules/cadastro/cadastro_module.dart';
import 'package:app_melivra/app/modules/esqueci_senha/esqueci_senha_module.dart';
import 'package:app_melivra/app/modules/home/home_module.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:app_melivra/app/modules/institutos/institutos_module.dart';
import 'package:app_melivra/app/modules/login/login_module.dart';
import 'package:app_melivra/app/modules/meu_perfil/meu_perfil_module.dart';
import 'package:app_melivra/app/modules/perfil/perfil_module.dart';
import 'package:app_melivra/app/modules/professores/professores_module.dart';
import 'package:app_melivra/app/modules/sobre_app/sobre_app_module.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/solicitar_retirada_module.dart';
import 'package:app_melivra/app/modules/splash/splash_module.dart';
import 'package:app_melivra/app/modules/suggestions/suggestions_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/instituto_details/instituto_details_module.dart';
import 'modules/professores_details/professores_details_module.dart';
import 'modules/ranking_institutos/ranking_institutos_module.dart';
import 'modules/search/search_module.dart';

class AppModule extends Module {
  static String get routeName => SplashModule.routeName;

  void routes(RouteManager r) {
    r.module(
      SplashModule.routeName,
      module: SplashModule(),
    );
    r.module(
      InicioModule.routeName,
      module: InicioModule(),
    );
    r.module(
      CadastroModule.routeName,
      module: CadastroModule(),
    );
    r.module(
      LoginModule.routeName,
      module: LoginModule(),
    );
    r.module(
      EsqueciSenhaModule.routeName,
      module: EsqueciSenhaModule(),
    );
    r.module(
      HomeModule.routeName,
      module: HomeModule(),
    );
    r.module(
      BottomNavigationModule.routeName,
      module: BottomNavigationModule(),
    );
    r.module(
      RankingInstitutosModule.routeName,
      module: RankingInstitutosModule(),
    );
    r.module(
      ProfessoresModule.routeName,
      module: ProfessoresModule(),
    );
    r.module(
      InstitutosModule.routeName,
      module: InstitutosModule(),
    );
    r.module(
      PerfilModule.routeName,
      module: PerfilModule(),
    );
    r.module(
      InstitutoDetailsModule.routeName,
      module: InstitutoDetailsModule(),
    );
    r.module(
      ProfessoresDetailsModule.routeName,
      module: ProfessoresDetailsModule(),
    );
    r.module(
      SearchModule.routeName,
      module: SearchModule(),
    );
    r.module(
      MeuPerfilModule.routeName,
      module: MeuPerfilModule(),
    );
    r.module(
      SobreAppModule.routeName,
      module: SobreAppModule(),
    );
    r.module(
      SuggestionModule.routeName,
      module: SuggestionModule(),
    );
    r.module(
      AboutUsModule.routeName,
      module: AboutUsModule(),
    );
    r.module(
      SolicitarRetiradaModule.routeName,
      module: SolicitarRetiradaModule(),
    );
  }
}
