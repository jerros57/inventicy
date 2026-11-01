import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/models/item_inventario.dart';
import 'package:inventicy/screens/home_screen.dart';

void main() {
  group('Persistencia de Imágenes en Estado y copyWith', () {
    test('ItemInventario copyWith actualiza imageUrl manteniendo los demás campos', () {
      const original = ItemInventario(
        id: '1',
        codigoSku: 'SKU-TEST',
        nombre: 'Item Original',
        categoria: 'Electrónica',
        stock: 10,
        precio: 99.99,
        descripcion: 'Descripción',
        imageUrl: 'https://old.url/image.jpg',
      );

      final updated = original.copyWith(
        imageUrl: 'https://new.url/image_updated.jpg',
      );

      expect(updated.id, '1');
      expect(updated.codigoSku, 'SKU-TEST');
      expect(updated.nombre, 'Item Original');
      expect(updated.categoria, 'Electrónica');
      expect(updated.stock, 10);
      expect(updated.precio, 99.99);
      expect(updated.descripcion, 'Descripción');
      expect(updated.imageUrl, 'https://new.url/image_updated.jpg');
    });

    testWidgets('HomeScreen maneja retorno de DetailScreen y navegación de forma reactiva',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      expect(find.text('StockFlow Pro - Catálogo'), findsOneWidget);

      // Abre el detalle del primer producto
      await tester.tap(find.widgetWithText(FilledButton, 'Ver detalles').first);
      await tester.pumpAndSettle();

      expect(find.text('Detalle: LAP-001'), findsOneWidget);

      // Presiona retroceso retornando la imagen
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Confirma que regresa a HomeScreen sin problemas
      expect(find.text('StockFlow Pro - Catálogo'), findsOneWidget);
    });
  });
}

