import 'package:app_melivra/app/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'core/screen/design_ui.dart';
import 'core/screen/screen_util.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(AppModule.routeName);
    return ScreenUtil.builder(
      designUI: DesignUI.androidMaterial,
      designUITablet: DesignUI.androidMaterial,
      builder: (context, constraints, orientation) {
        return MaterialApp.router(
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          debugShowCheckedModeBanner: false,
          title: 'Me Livra',
          theme: lightTheme,
          themeMode: ThemeMode.light,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
