import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/main.dart';

void main() {
  testWidgets('StockFlowProApp splash screen and navigation to HomeScreen and DetailScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StockFlowProApp());

    // 1. Verifica los elementos de la pantalla de bienvenida (SplashScreen)
    expect(find.text('StockFlow'), findsOneWidget);
    expect(find.text('PRO'), findsOneWidget);
    expect(find.text('Control Inteligente de Inventario'), findsOneWidget);
    expect(find.text('Versión 2.0.0'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 2. Simula el paso de los 2 segundos para redirigir a HomeScreen
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // 3. Verifica que el catálogo y el AppBar de HomeScreen carguen
    expect(find.text('StockFlow Pro - Catálogo'), findsOneWidget);
    expect(find.text('Laptop Pro 15 Ultra'), findsOneWidget);

    // 4. Encuentra el botón "Ver detalles" y navega a DetailScreen
    final detalleButton = find.widgetWithText(FilledButton, 'Ver detalles').first;
    expect(detalleButton, findsOneWidget);
    await tester.tap(detalleButton);
    await tester.pumpAndSettle();

    // 5. Verifica que DetailScreen reciba el producto y muestre título, precio, stock y descripción
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

    // 6. Presiona el botón de retroceso (arrow_back)
    final backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // 7. Confirma retorno a HomeScreen
    expect(find.text('StockFlow Pro - Catálogo'), findsOneWidget);
  });
}
