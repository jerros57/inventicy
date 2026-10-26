import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/main.dart';

void main() {
  testWidgets('InventicyApp smoke test and details modal', (WidgetTester tester) async {
    await tester.pumpWidget(const InventicyApp());

    // Verifica que el catálogo y el AppBar carguen
    expect(find.text('Inventicy - Catálogo'), findsOneWidget);
    expect(find.text('Laptop Pro 15 Ultra'), findsOneWidget);

    // Encuentra el botón "Ver detalles" y lo presiona
    final detalleButton = find.widgetWithText(FilledButton, 'Ver detalles').first;
    expect(detalleButton, findsOneWidget);
    await tester.tap(detalleButton);
    await tester.pumpAndSettle();

    // Verifica que el modal muestre la información detallada
    expect(find.text('SKU: LAP-001'), findsOneWidget);
    expect(find.text('Cerrar'), findsOneWidget);

    // Cierra el modal
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
  });
}
