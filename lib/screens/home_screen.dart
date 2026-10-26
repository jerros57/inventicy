import 'package:flutter/material.dart';
import '../models/item_inventario.dart';

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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.inventory_2_outlined, color: Colors.indigo),
            const SizedBox(width: 8),
            Expanded(child: Text(item.nombre)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'SKU: ${item.codigoSku}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('Categoría: ${item.categoria}'),
              const SizedBox(height: 6),
              Text(
                'Precio: \$${item.precio.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                'Stock disponible: ${item.stock} unidades',
                style: TextStyle(
                  color: item.stock < 5 ? Colors.red.shade700 : Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Descripción:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(item.descripcion),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cerrar'),
          ),
        ],
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
        padding: const EdgeInsets.all(12),
        itemCount: _productosPrueba.length,
        itemBuilder: (context, index) {
          final item = _productosPrueba[index];
          final esStockBajo = item.stock < 5;

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.inventory_2,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.nombre,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'SKU: ${item.codigoSku} • ${item.categoria}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${item.precio.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            esStockBajo
                                ? Icons.warning_amber_rounded
                                : Icons.check_circle_outline,
                            size: 18,
                            color: esStockBajo ? Colors.orange.shade800 : Colors.green.shade700,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Stock: ${item.stock}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: esStockBajo ? Colors.orange.shade800 : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () => _mostrarDetalles(context, item),
                        icon: const Icon(Icons.info_outline, size: 18),
                        label: const Text('Ver detalles'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Alias para soporte de nombres
typedef InventarioScreen = HomeScreen;
