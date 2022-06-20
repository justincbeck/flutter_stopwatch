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

    return MaterialApp(
        title: 'Stopwatch',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Stopwatch'),
            ),
            body: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: 300,
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(stopWatchNotifier.getLapTime(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w200)),
                        ),
                        Container(
                          width: 265,
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Text(stopWatchNotifier.getTime(), style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w200)),
                        )
                      ],
                    ),
                  ),
                ]),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 300,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: _buildButtonColumns(stopWatchNotifier)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: stopWatchNotifier.getLaps().length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color.fromRGBO(220, 220, 220, 1)),
                              ),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Lap ${(stopWatchNotifier.getLaps().length - index).toString()}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.grey,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(stopWatchNotifier.getLaps()[stopWatchNotifier.getLaps().length - index - 1].toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ),
                            ]),
                          ),
                        );
                      }),
                ),
              ],
            )));
  }
}

List<Column> _buildButtonColumns(StopWatchNotifier stopWatchNotifier) {
  List<Column> buttons = [];

  if (stopWatchNotifier.isRunning()) {
    buttons.add(_buildButtonColumn(stopWatchNotifier.stop, 'Stop'));
    buttons.add(_buildButtonColumn(stopWatchNotifier.lap, 'Lap'));
  } else {
    buttons.add(_buildButtonColumn(stopWatchNotifier.start, 'Start'));
    buttons.add(_buildButtonColumn(stopWatchNotifier.reset, 'Reset'));
  }

  return buttons;
}

Column _buildButtonColumn(Function action, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
          onPressed: () {
            action();
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24),
          ),
          child: Text(label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ))),
    ],
  );
}
