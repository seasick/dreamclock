import 'package:flutter_daydream/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Current time is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that there is the current hour on the screen
    expect(find.text(DateTime.now().hour.toString()), findsAtLeast(1));
    expect(find.text(DateTime.now().minute.toString()), findsAtLeast(1));
    expect(find.text(DateTime.now().second.toString()), findsAtLeast(1));
  });
}
