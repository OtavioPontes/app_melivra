import 'package:app_melivra/app/core/style/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
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

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return ScreenUtil.builder(
      designUI: DesignUI.iPhone12ProMax,
      designUITablet: DesignUI.iPadPro12dot9,
      builder: (context, constraints, orientation) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Me Livra',
          theme: ThemesMeLivra.light,
          initialRoute: AppModule.initialRoute,
          navigatorObservers: <NavigatorObserver>[observer],
          supportedLocales: const [
            Locale('pt', 'BR'),
          ],
        ).modular();
      },
    );
  }
}
