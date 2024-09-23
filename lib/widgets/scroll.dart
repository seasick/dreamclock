import 'dart:async';

import 'package:flutter/material.dart';

class Scroll extends StatefulWidget {
  const Scroll({super.key, required this.child, this.interval = 1});

  final Widget child;
  final int interval;

  @override
  ScrollState createState() => ScrollState();
}

class ScrollState extends State<Scroll> {
  late Timer _timer;
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: widget.interval),
      (Timer t) => _setOffset(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      double maxOffset = (isPortrait ? height : width) / 2;
      maxOffset -= maxOffset * 0.4;

      _offset += 8;

      if (_offset > maxOffset) {
        _offset = -maxOffset;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double xOffset = 0;
    double yOffset = 0;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      yOffset = _offset;
    } else {
      xOffset = _offset;
    }

    return Container(
      transform: Matrix4.translationValues(
        xOffset,
        yOffset,
        0.0,
      ),
      child: widget.child,
    );
  }
}
