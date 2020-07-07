import 'dart:async';

import 'package:flutter/services.dart';

import 'content/content.dart';

class Flutternativeaccess {
  static const MethodChannel _channel =
      const MethodChannel('flutter_native_access');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> keepScreenOn(bool isKeepScreenOn) async {
    bool result = await _channel
        .invokeMethod(KEEP_SCREEN_ON, {IS_KEEP_SCREEN_ON: isKeepScreenOn});
    return Future.value(result);
  }
}
