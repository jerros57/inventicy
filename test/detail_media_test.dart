import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/models/item_inventario.dart';
import 'package:inventicy/screens/detail_screen.dart';

void main() {
  const testItem = ItemInventario(
    id: 'test-1',
    codigoSku: 'SKU-TEST-99',
    nombre: 'Producto Multimedia',
    categoria: 'Dispositivos',
    stock: 8,
    precio: 299.99,
    descripcion: 'Descripción del producto de prueba con soporte multimedia.',
  );

  testWidgets('DetailScreen displays image preview and opens media bottom sheet',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DetailScreen(item: testItem),
      ),
    );

    // 1. Verifica la renderización de la pantalla y el botón de cambiar foto
    expect(find.text('Detalle: SKU-TEST-99'), findsOneWidget);
    expect(find.text('Cambiar foto del producto'), findsAtLeast(1));

    // 2. Abre el BottomSheet
    final changePhotoButton =
        find.widgetWithText(OutlinedButton, 'Cambiar foto del producto');
    expect(changePhotoButton, findsOneWidget);
    await tester.tap(changePhotoButton);
    await tester.pumpAndSettle();

    // 3. Verifica las opciones dentro del BottomSheet
    expect(find.text('Tomar foto con Cámara'), findsOneWidget);
    expect(find.text('Elegir de Galería'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt_rounded), findsOneWidget);
    expect(find.byIcon(Icons.photo_library_rounded), findsOneWidget);
  });
}

