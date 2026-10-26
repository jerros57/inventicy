import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/models/item_inventario.dart';
import 'package:inventicy/widgets/product_card.dart';

void main() {
  testWidgets('ProductCard renders item details and handles onTap', (WidgetTester tester) async {
    const item = ItemInventario(
      id: 'test-1',
      codigoSku: 'SKU-001',
      nombre: 'Mouse Óptico',
      categoria: 'Periféricos',
      stock: 10,
      precio: 25.50,
      descripcion: 'Mouse ergonómico',
    );

    var tapCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(
            item: item,
            onTap: () => tapCount++,
          ),
        ),
      ),
    );

    expect(find.text('Mouse Óptico'), findsOneWidget);
    expect(find.text('SKU: SKU-001 • Periféricos'), findsOneWidget);
    expect(find.text('Stock: 10'), findsOneWidget);
    expect(find.text('\$25.50'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Tap en el botón "Ver detalles"
    await tester.tap(find.widgetWithText(FilledButton, 'Ver detalles'));
    await tester.pump();
    expect(tapCount, 1);

    // Tap en la tarjeta completa (InkWell exterior)
    await tester.tap(find.byType(InkWell).first);
    await tester.pump();
    expect(tapCount, 2);
  });
}
