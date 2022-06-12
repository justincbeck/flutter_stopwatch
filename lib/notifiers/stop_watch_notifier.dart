import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'package:stopwatch/models/stop_watch.dart';

class StopWatchNotifier with ChangeNotifier {
  final StopWatch _stopWatch = StopWatch();
  late Timer _timer;
  Logger logger = Logger();

  isRunning() {
    return _stopWatch.running;
  }

  getTime() {
    num currentMillis = _getTotalMillis();
    num hours = (currentMillis / (60 * 60 * 1000)).floor() % 24;
    num minutes = (currentMillis / (60 * 1000)).floor() % 60;
    num seconds = (currentMillis / 1000).floor() % 60;
    num millis = currentMillis % 60;

    String paddedHours = _pad(hours);
    String paddedMinutes = _pad(minutes);
    String paddedSeconds = _pad(seconds);
    String paddedMillis = _pad(millis);

    if (hours > 0) {
      return "$paddedHours:$paddedMinutes:$paddedSeconds";
    }
    return "$paddedMinutes:$paddedSeconds.$paddedMillis";
  }

  String _pad(num number) {
    if (number < 10) {
      return "0$number";
    } else {
      return number.toString();
    }
  }

  _getTotalMillis() {
    return _stopWatch.totalMillis;
  }

  start() {
    DateTime start = DateTime.now();
    _stopWatch.start = start.millisecondsSinceEpoch - _stopWatch.totalMillis;
    _stopWatch.lapStart = start.millisecondsSinceEpoch - _stopWatch.lapMillis;
    _stopWatch.running = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      DateTime now = DateTime.now();
      _stopWatch.totalMillis = now.millisecondsSinceEpoch - _stopWatch.start;
      _stopWatch.lapMillis = now.millisecondsSinceEpoch - _stopWatch.lapStart;
      notifyListeners();
    });
  }

  stop() {
    _timer.cancel();
    _stopWatch.running = false;
    notifyListeners();
  }

  lap() {
    DateTime now = DateTime.now();
    _stopWatch.lapStart = now.millisecondsSinceEpoch;
    _stopWatch.laps.add(_stopWatch.lapMillis);
    notifyListeners();
  }

  reset() {
    _stopWatch.totalMillis = 0;
    _stopWatch.lapMillis = 0;
    notifyListeners();
  }
}
