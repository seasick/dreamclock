// This is a dart context extension. It will expose the current intent to the context.

import 'package:flutter/material.dart';
import 'package:receive_intent/receive_intent.dart' as ri;

extension IntentContextExtension<T> on BuildContext {
  static ri.Intent? _intent;
  static bool _loaded = false;

  Future<void> loadIntent() async {
    if (_loaded) {
      return;
    }

    final receivedIntent = await ri.ReceiveIntent.getInitialIntent();

    debugPrint('Received intent: $receivedIntent');
    debugPrint('Action: ${receivedIntent?.action}');

    _intent = receivedIntent;
    _loaded = true;
  }

  ri.Intent? get intent {
    return _intent;
  }
}
