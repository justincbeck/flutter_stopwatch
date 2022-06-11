class StopWatch {
  num timeInterval = -1;
  num start = 0;
  num lapStart = 0;
  num totalMillis = 0;
  num lapMillis = 0;
  List<num> laps = [];

  StopWatch();

  StopWatch.fromMap(Map<String, dynamic> data) {
    timeInterval = data['timeInterval'];
    start = data['start'];
    lapStart = data['lapStart'];
    totalMillis = data['totalMillis'];
    laps = data['laps'];
  }

  Map<String, dynamic> toMap() {
    return {
      'timeInterval': timeInterval,
      'start': start,
      'lapStart': lapStart,
      'totalMillis': totalMillis,
      'laps': laps,
    };
  }
}
