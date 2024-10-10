import 'package:flutter_daydream/extensions/initial_route.dart';
import 'package:flutter_daydream/screens/dream_screen.dart';
import 'package:flutter_daydream/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    // Set color schemes for light and dark modes
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(195, 0, 89, 255),
      brightness: Brightness.light,
    );

    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(195, 0, 89, 255),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      initialRoute: context.initialRoute ?? 'dream',
      routes: {
        'dream': (context) => const DreamScreen(showSettingsButton: false),
        'main': (context) => const DreamScreen(showSettingsButton: true),
        'settings': (context) => const Settings(),
      },
      title: 'Digital Clock',
      theme: ThemeData(
        colorScheme: isDarkMode ? darkColorScheme : lightColorScheme,
      ),
    );
  }
}
