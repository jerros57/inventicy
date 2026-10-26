import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/models/item_inventario.dart';

void main() {
  group('ItemInventario Serialization', () {
    test('fromJson deserializes correctly', () {
      final json = {
        'id': 'item-123',
        'codigoSku': 'SKU-TEST',
        'nombre': 'Producto Test',
        'categoria': 'Hardware',
        'stock': 15,
        'precio': 199.99,
        'descripcion': 'Descripción de prueba',
      };

      final item = ItemInventario.fromJson(json);

      expect(item.id, 'item-123');
      expect(item.codigoSku, 'SKU-TEST');
      expect(item.nombre, 'Producto Test');
      expect(item.categoria, 'Hardware');
      expect(item.stock, 15);
      expect(item.precio, 199.99);
      expect(item.descripcion, 'Descripción de prueba');
    });

    test('toJson serializes correctly', () {
      const item = ItemInventario(
        id: 'item-123',
        codigoSku: 'SKU-TEST',
        nombre: 'Producto Test',
        categoria: 'Hardware',
        stock: 15,
        precio: 199.99,
        descripcion: 'Descripción de prueba',
      );

      final json = item.toJson();

      expect(json['id'], 'item-123');
      expect(json['codigoSku'], 'SKU-TEST');
      expect(json['nombre'], 'Producto Test');
      expect(json['categoria'], 'Hardware');
      expect(json['stock'], 15);
      expect(json['precio'], 199.99);
      expect(json['descripcion'], 'Descripción de prueba');
    });
  });
}
