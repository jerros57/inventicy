import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/item_inventario.dart';

class ProductCard extends StatelessWidget {
  final ItemInventario item;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  Widget _buildThumbnailImage() {
    final url = item.imageUrl ??
        'https://res.cloudinary.com/dgv0mdsb/image/upload/c_fill,w_300,h_300,q_auto,f_auto/v1/samples/ecommerce/analog-classic.jpg';

    Widget fallback(
            BuildContext context, Object error, StackTrace? stackTrace) =>
        Container(
          width: 65,
          height: 65,
          color: const Color(0xFFF1F5F9),
          child: const Icon(Icons.inventory_2_outlined,
              color: Color(0xFF0D9488)),
        );

    if (url.startsWith('http://') ||
        url.startsWith('https://') ||
        url.startsWith('blob:')) {
      return Image.network(
        url,
        width: 65,
        height: 65,
        fit: BoxFit.cover,
        errorBuilder: fallback,
      );
    } else if (!kIsWeb) {
      return Image.file(
        File(url),
        width: 65,
        height: 65,
        fit: BoxFit.cover,
        errorBuilder: fallback,
      );
    }

    return Container(
      width: 65,
      height: 65,
      color: const Color(0xFFF1F5F9),
      child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF0D9488)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildThumbnailImage(),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nombre,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SKU: ${item.codigoSku} • ${item.categoria}',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          item.stock > 5
                              ? Icons.check_circle_outline
                              : Icons.warning_amber_rounded,
                          size: 16,
                          color: item.stock > 5 ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Stock: ${item.stock}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color:
                                item.stock > 5 ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${item.precio.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.tonalIcon(
                    onPressed: onTap,
                    icon: const Icon(Icons.info_outline, size: 16),
                    label: const Text('Ver detalles',
                        style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
