import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // Showing the settings button means that the app launched explicitly by the user
    // and we should navigate back to the main screen when closing. Otherwise we use `exit()`.
    if (widget.showSettingsButton) {
      SystemNavigator.pop();
    } else {
      // Using exit() is not recommended, but I've not found another working solution to close it
      // when it was opened through DreamService/Screensaver preview.
      exit(0);
    }
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
