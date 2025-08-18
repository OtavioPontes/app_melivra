import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  AppInfo._internal();

  static final AppInfo _instance = AppInfo._internal();
  static AppInfo get instance => _instance;

  String? _device;
  String? _manufacturer;
  String? _model;
  String? _os;
  PackageInfo? _packageInfo;

  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;

  String get device => _verifyInit(_device);
  String get manufacturer => _verifyInit(_manufacturer);
  String get model => _verifyInit(_model);
  String get os => _verifyInit(_os);
  PackageInfo get packageInfo => _verifyInit(_packageInfo);

  static Future<AppInfo> init() async {
    if (_instance.isInitSuccessfully) return _instance;

    try {
      _instance._packageInfo = await PackageInfo.fromPlatform();
      final deviceInfoPlugin = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        _instance._androidDeviceInfo = await deviceInfoPlugin.androidInfo;
        _instance._device = _instance._androidDeviceInfo?.device;
        _instance._manufacturer = _instance._androidDeviceInfo?.manufacturer;
        _instance._model = _instance._androidDeviceInfo?.model;
        _instance._os =
            'Android ${_instance._androidDeviceInfo?.version.release} - SDK ${_instance._androidDeviceInfo?.version.sdkInt}';
      } else if (Platform.isIOS) {
        _instance._iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        _instance._device = _instance._iosDeviceInfo?.localizedModel;
        _instance._manufacturer = 'Apple Inc';
        _instance._model = _instance._iosDeviceInfo?.model;
        _instance._os =
            '${_instance._iosDeviceInfo?.systemName} ${_instance._iosDeviceInfo?.systemVersion}';
      }

      return _instance;
    } catch (e) {
      throw Exception('Falha ao iniciar o AppInfo');
    }
  }

  bool get isInitSuccessfully =>
      _device != null ||
      _manufacturer != null ||
      _model != null ||
      _os != null ||
      _packageInfo != null;

  dynamic _verifyInit(dynamic variable) {
    if (variable == null) throw Exception('AppInfo não foi inicializado');

    return variable;
  }
}
