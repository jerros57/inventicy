import 'package:flutter/material.dart';
import '../models/item_inventario.dart';

import '../widgets/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<ItemInventario> _productosPrueba = [
    ItemInventario(
      id: '1',
      codigoSku: 'LAP-001',
      nombre: 'Laptop Pro 15 Ultra',
      categoria: 'Computación',
      stock: 12,
      precio: 1299.99,
      descripcion:
          'Portátil de alto rendimiento con procesador octa-core y 16GB RAM para tareas profesionales.',
    ),
    ItemInventario(
      id: '2',
      codigoSku: 'MON-4K-02',
      nombre: 'Monitor 27" UHD 4K',
      categoria: 'Monitores',
      stock: 3,
      precio: 349.50,
      descripcion:
          'Monitor IPS con resolución 4K, tasa de refresco 75Hz y calibración de color profesional.',
    ),
    ItemInventario(
      id: '3',
      codigoSku: 'TEC-MEC-03',
      nombre: 'Teclado Mecánico RGB',
      categoria: 'Periféricos',
      stock: 24,
      precio: 89.90,
      descripcion:
          'Teclado mecánico con switches táctiles, retroiluminación RGB configurable y cable trenzado.',
    ),
    ItemInventario(
      id: '4',
      codigoSku: 'MOU-ERG-04',
      nombre: 'Mouse Inalámbrico Ergonómico',
      categoria: 'Accesorios',
      stock: 4,
      precio: 45.00,
      descripcion:
          'Mouse vertical diseñado para reducir la fatiga en la muñeca con sensor óptico de alta precisión.',
    ),
    ItemInventario(
      id: '5',
      codigoSku: 'AUR-BT-05',
      nombre: 'Auriculares Inalámbricos Pro',
      categoria: 'Audio',
      stock: 18,
      precio: 119.00,
      descripcion:
          'Auriculares con cancelación activa de ruido, micrófono con IA y batería de hasta 30 horas.',
    ),
  ];

  void _mostrarDetalles(BuildContext context, ItemInventario item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventicy - Catálogo'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualizar catálogo',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Catálogo actualizado'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _productosPrueba.length,
        itemBuilder: (context, index) {
          final item = _productosPrueba[index];
          return ProductCard(
            item: item,
            onTap: () => _mostrarDetalles(context, item),
          );
        },
      ),
    );
  }
}

/// Alias para soporte de nombres
typedef InventarioScreen = HomeScreen;
