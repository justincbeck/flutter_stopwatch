import 'package:flutter/material.dart';
import 'dart:async';
import 'package:stopwatch/models/stop_watch.dart';

class StopWatchNotifier with ChangeNotifier {
  final StopWatch _stopWatch = StopWatch();
  late Timer _timer;

  getTotalMillis() {
    return _stopWatch.totalMillis;
  }

  start() {
    DateTime start = DateTime.now();
    _stopWatch.start = start.millisecondsSinceEpoch - _stopWatch.totalMillis;
    _stopWatch.lapStart = start.millisecondsSinceEpoch - _stopWatch.lapMillis;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      DateTime now = DateTime.now();
      _stopWatch.totalMillis = now.millisecondsSinceEpoch - _stopWatch.start;
      _stopWatch.lapMillis = now.millisecondsSinceEpoch - _stopWatch.lapStart;
      notifyListeners();
    });
  }

  stop() {
    _timer.cancel();
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
