// This is a dart context extension. It will expose the initialRoute property to the BuildContext class.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension InitialRouteContextExtension<T> on BuildContext {
  static const platform = MethodChannel('seasickgames.com/daydream');

  static String? _initialRoute;
  static bool _loaded = false;

  Future<void> loadInitialRoute() async {
    if (_loaded) {
      return;
    }

    try {
      final result = await platform.invokeMethod<String>('getInitialRoute');
      debugPrint("Received initialRoute: $result");
      _initialRoute = result;
    } on PlatformException catch (e) {
      debugPrint("Failed to get initialRoute: '${e.message}'.");
    }

    _loaded = true;
  }

  String? get initialRoute {
    return _initialRoute;
  }
}
