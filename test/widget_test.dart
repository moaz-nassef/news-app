import 'package:flutter_test/flutter_test.dart';

import 'package:news_app/main.dart';

void main() {
  testWidgets('App starts on the splash screen and navigates home',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Splash screen is shown first.
    expect(find.text('News App'), findsOneWidget);

    // Advance through the splash delay and let pending timers/animations settle.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(seconds: 3));

    // The home screen should now be visible.
    expect(find.text('Discover'), findsOneWidget);
  });
}