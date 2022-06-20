import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'package:stopwatch/models/stop_watch.dart';

class StopWatchNotifier with ChangeNotifier {
  final StopWatch _stopWatch = StopWatch();
  late Timer _timer;
  Logger logger = Logger();

  void start() {
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

  void stop() {
    _timer.cancel();
    _stopWatch.running = false;
    notifyListeners();
  }

  void lap() {
    DateTime now = DateTime.now();
    _stopWatch.lapStart = now.millisecondsSinceEpoch;
    _stopWatch.laps.add(_stopWatch.lapMillis);
    notifyListeners();
  }

  void reset() {
    _stopWatch.totalMillis = 0;
    _stopWatch.lapMillis = 0;
    _stopWatch.laps = [];
    notifyListeners();
  }

  bool isRunning() {
    return _stopWatch.running;
  }

  String getTime() {
    return _formatTime(_getTotalMillis());
  }

  String getLapTime() {
    return _formatTime(_getLapMillis());
  }

  List<String> getLaps() {
    return _stopWatch.laps.map((lap) => _formatTime(lap)).toList();
  }

  num _getTotalMillis() {
    return _stopWatch.totalMillis;
  }

  num _getLapMillis() {
    return _stopWatch.lapMillis;
  }

  String _formatTime(timeInMillis) {
    num hours = (timeInMillis / (60 * 60 * 1000)).floor() % 24;
    num minutes = (timeInMillis / (60 * 1000)).floor() % 60;
    num seconds = (timeInMillis / 1000).floor() % 60;
    num millis = timeInMillis % 60;

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
    return number < 10 ? "0$number" : number.toString();
  }
}
