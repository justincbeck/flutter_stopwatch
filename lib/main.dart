import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/screens/home_screen.dart';
import 'notifiers/stop_watch_notifier.dart';

Future<void> main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => StopWatchNotifier(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State createState() {
    return AppState();
  }
}

class AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'Stop Watch App'),
    );
  }
}
