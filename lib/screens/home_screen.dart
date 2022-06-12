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
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(stopWatchNotifier.getLapTime(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w200)),
              Text(stopWatchNotifier.getTime(), style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w200)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: _buildButtonColumns(stopWatchNotifier)),
            ListView.builder(
                shrinkWrap: true,
                itemCount: stopWatchNotifier.getLaps().length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 50,
                    child: Center(child: Text(stopWatchNotifier.getLaps()[index].toString())),
                  );
                }),
          ],
        ));
  }
}

List<Column> _buildButtonColumns(StopWatchNotifier stopWatchNotifier) {
  List<Column> buttons = [];

  if (stopWatchNotifier.isRunning()) {
    buttons.add(_buildButtonColumn(stopWatchNotifier.stop, const Icon(Icons.stop, color: Colors.blue), 'Stop'));
    buttons.add(_buildButtonColumn(stopWatchNotifier.lap, const Icon(Icons.refresh, color: Colors.blue), 'Lap'));
  } else {
    buttons.add(_buildButtonColumn(stopWatchNotifier.start, const Icon(Icons.add, color: Colors.blue), 'Play'));
    buttons.add(_buildButtonColumn(stopWatchNotifier.reset, const Icon(Icons.refresh, color: Colors.blue), 'Reset'));
  }

  return buttons;
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
