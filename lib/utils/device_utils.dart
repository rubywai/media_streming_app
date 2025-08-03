import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<bool> isDeviceAndroidTV() async {
  if (kIsWeb ||
      Platform.isIOS ||
      Platform.isMacOS ||
      Platform.isWindows ||
      Platform.isLinux) {
    return false;
  }

  final deviceInfoPlugin = DeviceInfoPlugin();
  final androidInfo = await deviceInfoPlugin.androidInfo;

  final features = androidInfo.systemFeatures;

  return features.contains('android.hardware.type.television') ||
      features.contains('android.software.leanback');
}
