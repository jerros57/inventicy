import 'package:flutter_test/flutter_test.dart';

import 'package:inventicy/main.dart';

void main() {
  testWidgets('InventicyApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const InventicyApp());

    expect(find.text('Inventicy - Setup Inicial'), findsOneWidget);
  });
}
