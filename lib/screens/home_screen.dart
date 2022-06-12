import 'package:flutter/material.dart';
import 'package:stopwatch/notifiers/stop_watch_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    StopWatchNotifier stopWatchNotifier = Provider.of<StopWatchNotifier>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Stop Watch Demo'),
        ),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(stopWatchNotifier.getTime(), style: const TextStyle(fontSize: 60)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildButtonColumn(stopWatchNotifier.start, const Icon(Icons.add, color: Colors.blue), 'Play'),
              _buildButtonColumn(stopWatchNotifier.stop, const Icon(Icons.stop, color: Colors.blue), 'Stop'),
              _buildButtonColumn(stopWatchNotifier.reset, const Icon(Icons.refresh, color: Colors.blue), 'Reset'),
            ])
          ],
        ));
  }
}

Column _buildButtonColumn(Function action, Icon icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: icon,
        onPressed: () {
          action();
        },
      ),
      Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.blue,
              )))
    ],
  );
}
