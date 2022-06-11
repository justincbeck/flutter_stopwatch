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
            Row(children: [
              Text(stopWatchNotifier.getTotalMillis().toString()),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.blue),
                    onPressed: () {
                      stopWatchNotifier.start();
                    },
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const Text('Play',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          )))
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.stop, color: Colors.blue),
                    onPressed: () {
                      stopWatchNotifier.stop();
                    },
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const Text('Stop',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          )))
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.blue),
                    onPressed: () {
                      stopWatchNotifier.reset();
                    },
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const Text('Reset',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          )))
                ],
              )
            ])
          ],
        ));
  }
}
