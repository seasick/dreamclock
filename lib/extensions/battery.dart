import 'dart:async';

import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

extension BatteryContextExtension<T> on BuildContext {
  static final Battery _battery = Battery();
  static int? _batteryLevel;
  static bool _loaded = false;
  static final Timer _timer = Timer.periodic(
    const Duration(seconds: 30),
    (Timer t) => _updateBatteryLevel(),
  );

  // TODO Cancel timer on cleanup

  Future<void> loadBattery() async {
    if (_loaded) {
      return;
    }

    debugPrint('Loading battery');
    await _updateBatteryLevel();

    _loaded = true;
  }

  get batteryLevel {
    return _batteryLevel;
  }

  static Future<void> _updateBatteryLevel() async {
    _batteryLevel = await _battery.batteryLevel;
    debugPrint('Battery level: $_batteryLevel');
  }
}
