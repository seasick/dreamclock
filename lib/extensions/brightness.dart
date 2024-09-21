import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension BrightnessContextExtension<T> on BuildContext {
  static final Brightness _brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  static final bool isDarkMode = _brightness == Brightness.dark;

  get brightness {
    return _brightness;
  }
}
