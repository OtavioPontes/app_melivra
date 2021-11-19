import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  static String get initialRoute => '';

  @override
  List<Bind> get binds => [
        // ------------------------ STORES ------------------------

        // --------------------- CONTROLLERS ----------------------

        // ---------------------- USE CASES -----------------------

        // --------------------- REPOSITORIES ---------------------

        // --------------------- DATA SOURCES ---------------------

        // ----------------------- SERVICES -----------------------

        // -------------------- NOTIFICATIONS ---------------------
      ];

  @override
  final List<Module> imports = [];

  @override
  final List<ModularRoute> routes = [];
}
