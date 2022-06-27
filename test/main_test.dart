import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/main.dart';

void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    const myApp = MyApp();
    await tester.pumpWidget(myApp);
    // final titleFinder = find.text('Stop Watch App');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    // expect(titleFinder, findsOneWidget);
  });
}
