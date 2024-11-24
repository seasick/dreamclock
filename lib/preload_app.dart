import 'package:dreamclock/app.dart';
import 'package:dreamclock/extensions/alarm.dart';
import 'package:dreamclock/extensions/battery.dart';
import 'package:dreamclock/extensions/fonts.dart';
import 'package:dreamclock/extensions/initial_route.dart';
import 'package:dreamclock/extensions/settings.dart';
import 'package:flutter/material.dart';

class PreloadApp extends StatefulWidget {
  const PreloadApp({super.key});

  @override
  PreloadAppState createState() => PreloadAppState();
}

class PreloadAppState extends State<PreloadApp> {
  @override
  void deactivate() {
    context.deactivateBattery();

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    List<Future> preLoad = [
      context.loadFonts(),
      context.loadAlarm(),
      context.loadInitialRoute(),
      context.loadSettings(),
      context.loadBattery(),
    ];

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder<dynamic>(
        future: Future.wait(preLoad),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children = [];

          if (snapshot.hasData) {
            debugPrint("Display App...");
            children = [
              const App(),
            ];
          } else if (snapshot.hasError) {
            debugPrint("LoadingWidgetState.build.error: ${snapshot.error}");
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            debugPrint("Display Loading...");
            children = const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Loading...',
                  textDirection: TextDirection.ltr,
                ),
              ),
            ];
          }

          return Stack(
            alignment: AlignmentDirectional.center,
            textDirection: TextDirection.ltr,
            children: children,
          );
        },
      ),
    );
  }
}
