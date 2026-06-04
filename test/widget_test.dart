import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:glory_burger/main.dart';
import 'package:glory_burger/providers/providers.dart';

void main() {
  testWidgets('App smoke test — renders without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FoodProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const GloryBurgerApp(),
      ),
    );
    // Advance past pending timers to avoid disposal errors
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    // Verify the app renders without crashing
    expect(find.byType(GloryBurgerApp), findsOneWidget);
  });
}