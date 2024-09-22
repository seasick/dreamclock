import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_daydream/preload_app.dart';

void main() {
  runApp(const PreloadApp());

  // Immersive aka hide status bar and navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}
