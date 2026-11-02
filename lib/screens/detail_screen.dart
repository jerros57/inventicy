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
<<<<<<< Updated upstream
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
=======
              ),
              const SizedBox(height: 8),
              Text(
                widget.item.descripcion,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),

              const SizedBox(height: 24),

              // Botón interactivo para disparar notificación de alerta
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: _dispararAlertaStock,
                  icon:
                      const Icon(Icons.notifications_active_outlined, size: 20),
                  label: const Text('Disparar Alerta de Stock Crítico'),
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFDC2626).withValues(alpha: 0.12),
                    foregroundColor: const Color(0xFFDC2626),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              // Espacio de separación para evitar solapamiento con el FAB extendido
              const SizedBox(height: 80),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showMediaSourceBottomSheet,
          backgroundColor: secondaryTeal,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.camera_alt_outlined),
          label: const Text('Cambiar foto del producto'),
>>>>>>> Stashed changes
        ),
      ),
    );
  }
}
