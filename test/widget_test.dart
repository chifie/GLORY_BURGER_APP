import 'package:flutter_test/flutter_test.dart';

import 'package:glory_burger/main.dart';

void main() {
  testWidgets('App smoke test — renders without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GloryBurgerApp());
    await tester.pumpAndSettle();

    // Verify the app renders the bottom navigation bar
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
