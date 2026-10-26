import 'package:flutter/material.dart';
import '../models/item_inventario.dart';

class DetailScreen extends StatelessWidget {
  final ItemInventario item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle: ${item.codigoSku}'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nombre,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text('Categoría: ${item.categoria}', style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 6),
                  Text(
                    'Precio unitario: \$${item.precio.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Información de Existencias:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  item.stock > 5 ? Icons.check_circle_outline : Icons.warning_amber_rounded,
                  color: item.stock > 5 ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text('Unidades en bodega: ${item.stock}', style: const TextStyle(fontSize: 15)),
              ],
            ),
            const Divider(height: 32),
            const Text(
              'Observaciones de Stock:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(item.descripcion, style: const TextStyle(fontSize: 14, height: 1.4)),
          ],
        ),
      ),
    );
  }
}
