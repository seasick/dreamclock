import 'dart:async';

import 'package:flutter_daydream/extensions/alarm.dart';
import 'package:flutter_daydream/extensions/battery.dart';
import 'package:flutter_daydream/extensions/settings.dart';
import 'package:flutter_daydream/widgets/scroll.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({super.key});

  @override
  DigitalClockState createState() => DigitalClockState();
}

class DigitalClockState extends State<DigitalClock> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    String formatString = '';

    if (context.settings.twentyFourHourFormat) {
      formatString += 'HH:mm';
    } else {
      formatString += 'hh:mm';
    }

    if (context.settings.showSeconds) {
      formatString += ':ss';
    }

    if (!context.settings.twentyFourHourFormat) {
      formatString += ' a';
    }

    DateFormat format = DateFormat(formatString);
    return format.format(dateTime);
  }

  String _formatAlarm(DateTime alarm) {
    String formatString = '';

    // If the alarm is more than 24 hours away, show the date
    if (alarm.difference(DateTime.now()).inDays > 0) {
      formatString += 'MMM d, ';
    }

    if (context.settings.twentyFourHourFormat) {
      formatString += 'HH:mm';
    } else {
      formatString += 'hh:mm a';
    }

    DateFormat format = DateFormat(formatString);
    return format.format(alarm);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = [
      Text(
        _timeString,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: context.settings.fontColor,
        ),
      ),
    ];

    if (context.settings.batteryPercentage) {
      elements.add(
        Text(
          "${context.batteryLevel}%",
          style: TextStyle(
            fontSize: 4,
            color: context.settings.fontColor,
          ),
        ),
      );
    }

    if (context.settings.alarm && context.alarm > 0) {
      DateTime alarmTime = DateTime.fromMillisecondsSinceEpoch(context.alarm);
      String alarmString = _formatAlarm(alarmTime);

      elements.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.alarm,
              size: 4,
              color: context.settings.fontColor,
            ),
            Text(
              " $alarmString",
              style: TextStyle(
                fontSize: 4,
                color: context.settings.fontColor,
              ),
            ),
          ],
        ),
      );
    }

    Widget clockWidget = FractionallySizedBox(
      widthFactor: 0.75, // width w.r.t to parent
      heightFactor: 0.75, // height w.r.t to parent
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          children: elements,
        ),
      ),
    );

    if (context.settings.burnInPrevention) {
      clockWidget = Scroll(
        interval: 5,
        child: clockWidget,
      );
    }

    return Scaffold(
      backgroundColor: context.settings.backgroundColor,
      body: Center(
        child: clockWidget,
      ),
    );
  }
}
