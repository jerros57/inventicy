import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/main.dart';

void main() {
  testWidgets('InventicyApp smoke test and navigation to DetailScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const InventicyApp());

    // 1. Verifica que el catálogo y el AppBar carguen
    expect(find.text('Inventicy - Catálogo'), findsOneWidget);
    expect(find.text('Laptop Pro 15 Ultra'), findsOneWidget);

    // 2. Encuentra el botón "Ver detalles" y navega a DetailScreen
    final detalleButton = find.widgetWithText(FilledButton, 'Ver detalles').first;
    expect(detalleButton, findsOneWidget);
    await tester.tap(detalleButton);
    await tester.pumpAndSettle();

    // 3. Verifica que DetailScreen reciba el producto y muestre título, precio, stock y descripción
    expect(find.text('Detalle: LAP-001'), findsOneWidget);
    expect(find.text('Laptop Pro 15 Ultra'), findsOneWidget);
    expect(find.text('Precio unitario: \$1299.99'), findsOneWidget);
    expect(find.text('Unidades en bodega: 12'), findsOneWidget);
    expect(
      find.text(
        'Portátil de alto rendimiento con procesador octa-core y 16GB RAM para tareas profesionales.',
      ),
      findsOneWidget,
    );

    // 4. Presiona el botón de retroceso (arrow_back)
    final backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // 5. Confirma retorno a HomeScreen
    expect(find.text('Inventicy - Catálogo'), findsOneWidget);
  });
}
