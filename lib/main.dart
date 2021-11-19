import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

late final FirebaseAnalytics firebaseAnalyticsProduction;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  firebaseAnalyticsProduction = FirebaseAnalytics();
  await firebaseAnalyticsProduction.setAnalyticsCollectionEnabled(false);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Isolate.current.addErrorListener(
    RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort,
  );

  // await AppInfoWay.init();
  // await LoggerWay.init(LoggerWayConfig.development());
  // await AuthWay.init(AuthWayConfig.development());
  // await SpoolWay.init(SpoolWayConfig.development(endpointConfigProduction));

  // Modular.to.addListener(() {
  //   LoggerWay.instance.information(description: '[FLOW] ${Modular.to.path}');
  // });

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
