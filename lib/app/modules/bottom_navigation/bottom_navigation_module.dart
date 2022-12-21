import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/controller/bottom_navigation_controller.dart';
import 'presentation/pages/bottom_navigation_page.dart';

class BottomNavigationModule extends Module {
  static const String routeName = '/bottomNavigation/';

  @override
  List<Bind> get binds => [
        // --------------------- CONTROLLERS ----------------------
        Bind((i) => BottomNavigationController()),
        // ---------------------- USE CASES -----------------------
        // --------------------- REPOSITORIES ---------------------
        // --------------------- DATA SOURCES ---------------------
        // ------------------------ OTHERS ------------------------
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const BottomNavigationPage(),
    ),
  ];
}
