import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_daydream/digital_clock.dart';

class DreamScreen extends StatelessWidget {
  const DreamScreen({super.key});

  void _onClose() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
