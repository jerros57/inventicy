import 'package:flutter/material.dart';
import '../models/item_inventario.dart';

import '../widgets/offline_banner.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ItemInventario> _productosPrueba;

  @override
  void initState() {
    super.initState();
    _productosPrueba = List.from(_productosIniciales);
  }

  static const List<ItemInventario> _productosIniciales = [
    ItemInventario(
      id: '1',
      codigoSku: 'LAP-001',
      nombre: 'Laptop Pro 15 Ultra',
      categoria: 'Computación',
      stock: 12,
      precio: 1299.99,
      descripcion:
          'Portátil de alto rendimiento con procesador octa-core y 16GB RAM para tareas profesionales.',
      imageUrl:
          'https://res.cloudinary.com/dgv0mdsb/image/upload/c_fill,w_300,h_300,q_auto,f_auto/v1/samples/ecommerce/laptop.jpg',
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
      imageUrl:
          'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=300',
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
      imageUrl:
          'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=300',
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
      imageUrl:
          'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=300',
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
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300',
    ),
  ];

  Future<void> _mostrarDetalles(BuildContext context, ItemInventario item) async {
    final nuevaImagen = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(item: item)),
    );

    if (nuevaImagen != null && nuevaImagen != item.imageUrl && mounted) {
      setState(() {
        final index = _productosPrueba.indexWhere((p) => p.id == item.id);
        if (index != -1) {
          _productosPrueba[index] =
              _productosPrueba[index].copyWith(imageUrl: nuevaImagen);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockFlow Pro - Catálogo'),
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
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}

/// Alias para soporte de nombres
typedef InventarioScreen = HomeScreen;
