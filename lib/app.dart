import 'package:flutter/material.dart';
import 'package:flutter_daydream/dream_screen.dart';
import 'package:screen_brightness/screen_brightness.dart';

class App extends StatelessWidget {
  const App({super.key});

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness.instance.setScreenBrightness(brightness);
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to set brightness';
    }
  }

  @override
  Widget build(BuildContext context) {
    setBrightness(0.0).then((x) {
      debugPrint('Brightness set to 0.0');
    });

    return MaterialApp(
      title: 'Digital Clock',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const DreamScreen(),
    );
  }
}
