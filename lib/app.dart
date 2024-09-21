import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_daydream/extensions/battery.dart';
import 'package:flutter_daydream/extensions/settings.dart';
import 'package:flutter_daydream/extensions/intent.dart';
import 'package:flutter_daydream/screens/dream_screen.dart';
import 'package:flutter_daydream/screens/settings.dart';
import 'package:flutter_daydream/widgets/loading.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    LoadingWidget loadingWrapper(Widget child) {
      List<Future> futures = [
        context.loadSettings(),
        context.loadIntent(),
        context.loadBattery(),
      ];
      return LoadingWidget(futures: futures, child: child);
    }

    // Set color schemes for light and dark modes
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(195, 0, 89, 255),
      brightness: Brightness.light,
    );

    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(195, 0, 89, 255),
      brightness: Brightness.dark,
    );

    debugPrint("App.build");

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => loadingWrapper(const DreamScreen()),
        '/settings': (context) => loadingWrapper(const Settings()),
      },
      title: 'Digital Clock',
      theme: ThemeData(
        colorScheme: isDarkMode ? darkColorScheme : lightColorScheme,
      ),
    );
  }
}
