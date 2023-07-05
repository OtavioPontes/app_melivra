import 'dart:async';
import 'dart:isolate';

import 'package:app_melivra/app/core/network/api_url.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/utils/appinfo.dart';

late final FirebaseAnalytics firebaseAnalytics;
late String url;
void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      AppModule.url = Api.prodUrl;
      await Firebase.initializeApp();
      final firebaseAnalytics = FirebaseAnalytics.instance;
      await firebaseAnalytics.setAnalyticsCollectionEnabled(false);
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
      await Hive.initFlutter();
      await Hive.openBox('melivra');
      await AppInfo.init();

      runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}
