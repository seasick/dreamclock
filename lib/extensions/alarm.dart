import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension AlarmContextExtension<T> on BuildContext {
  static const platform = MethodChannel('seasickgames.com/daydream');
  static bool _loaded = false;
  static int _alarm = 0; // 0 means no alarm set, otherwise it's UTC wall clock time in milliseconds

  static final Timer _timer = Timer.periodic(
    const Duration(seconds: 60),
    (Timer t) => _updateAlarmLevel(),
  );

  // Cancel timer on cleanup
  void deactivateAlarm() {
    _timer.cancel();
  }

  Future<void> loadAlarm() async {
    if (_loaded) {
      return;
    }

    debugPrint('Loading Alarm');
    await _updateAlarmLevel();

    _loaded = true;
  }

  get alarm {
    return _alarm;
  }

  static Future<void> _updateAlarmLevel() async {
    try {
      final result = await platform.invokeMethod<String>('getNextAlarm');
      debugPrint("Received getNextAlarm: $result");
      if (result != null && result.isNotEmpty) {
        _alarm = int.parse(result);
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get getNextAlarm: '${e.message}'.");
    }

    _loaded = true;
  }
}
