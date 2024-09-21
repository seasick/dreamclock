import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_daydream/extensions/intent.dart';
import 'package:flutter_daydream/extensions/settings.dart';
import 'package:flutter_daydream/widgets/digital_clock.dart';

class DreamScreen extends StatefulWidget {
  const DreamScreen({super.key});

  @override
  State<DreamScreen> createState() => _DreamScreenState();
}

class _DreamScreenState extends State<DreamScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _onClose() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "DreamScreen.build, ${context.settings.backgroundColor.red} ${context.settings.backgroundColor.green} ${context.settings.backgroundColor.blue}");
    bool hasAction = context.intent?.action != null;

    return Scaffold(
      floatingActionButton: hasAction
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Icon(Icons.settings),
            )
          : null,
      body: GestureDetector(
        onTap: _onClose,
        child: const FractionallySizedBox(
          widthFactor: 1.0, // width w.r.t to parent
          heightFactor: 1.0, // height w.r.t to parent
          child: Center(
            child: DigitalClock(),
          ),
        ),
      ),
    );
  }
}
