import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_daydream/widgets/digital_clock.dart';

class DreamScreen extends StatefulWidget {
  const DreamScreen({super.key, this.showSettingsButton = false});

  final bool showSettingsButton;

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
    debugPrint("DreamScreen.build");

    return Scaffold(
      floatingActionButton: widget.showSettingsButton
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'settings');
              },
              child: const Icon(Icons.settings),
            )
          : null,
      body: GestureDetector(
        onTap: _onClose,
        child: const DigitalClock(),
      ),
    );
  }
}
