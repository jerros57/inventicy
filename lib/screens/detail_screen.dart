import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/item_inventario.dart';
import '../services/media_service.dart';
import '../services/notification_service.dart';

class DetailScreen extends StatefulWidget {
  final ItemInventario item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final MediaService _mediaService = MediaService();
  final NotificationService _notificationService = NotificationService();
  Uint8List? _customImageBytes;
  late String? _imagenSeleccionada;

  @override
  void initState() {
    super.initState();
    _imagenSeleccionada = widget.item.imageUrl;
  }

  void _retrocederConResultado() {
    Navigator.pop(context, _imagenSeleccionada);
  }

  Future<void> _dispararAlertaStock() async {
    await _notificationService.mostrarNotificacion(
      titulo: 'Alerta de Stock Crítico: ${widget.item.nombre}',
      cuerpo:
          'Unidades bajas en bodega (${widget.item.stock} disponibles). SKU: ${widget.item.codigoSku}.',
      id: widget.item.id.hashCode,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notificación de alerta enviada al sistema nativo'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF0D9488),
      ),
    );
  }

  Future<void> _handleCameraSelection() async {
    Navigator.of(context).pop(); // Cierra el BottomSheet

    final permissionResult = await _mediaService.requestCameraPermission();

    if (!mounted) return;

    if (permissionResult == MediaPermissionResult.granted) {
      final photo = await _mediaService.takePhoto();
      if (photo != null) {
        final bytes = await photo.readAsBytes();
        if (!mounted) return;
        setState(() {
          _customImageBytes = bytes;
          _imagenSeleccionada = photo.path;
        });

        await _notificationService.mostrarNotificacion(
          titulo: 'Producto Actualizado: ${widget.item.codigoSku}',
          cuerpo:
              'Se ha capturado una nueva fotografía para ${widget.item.nombre}.',
          id: widget.item.id.hashCode,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Foto del producto capturada con éxito'),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF0D9488),
          ),
        );
      }
    } else if (permissionResult == MediaPermissionResult.permanentlyDenied) {
      _showPermissionDeniedDialog(
        title: 'Permiso de Cámara Denegado',
        content:
            'Para tomar fotos de los productos, debes habilitar el permiso de cámara desde la configuración del dispositivo.',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de cámara denegado'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
    }
  }

  Future<void> _handleGallerySelection() async {
    Navigator.of(context).pop(); // Cierra el BottomSheet

    final permissionResult = await _mediaService.requestGalleryPermission();

    if (!mounted) return;

    if (permissionResult == MediaPermissionResult.granted) {
      final image = await _mediaService.pickImageFromGallery();
      if (image != null) {
        final bytes = await image.readAsBytes();
        if (!mounted) return;
        setState(() {
          _customImageBytes = bytes;
          _imagenSeleccionada = image.path;
        });

        await _notificationService.mostrarNotificacion(
          titulo: 'Producto Actualizado: ${widget.item.codigoSku}',
          cuerpo:
              'Se ha seleccionado una nueva fotografía para ${widget.item.nombre}.',
          id: widget.item.id.hashCode,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Imagen seleccionada de la galería con éxito'),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF0D9488),
          ),
        );
      }
    } else if (permissionResult == MediaPermissionResult.permanentlyDenied) {
      _showPermissionDeniedDialog(
        title: 'Permiso de Galería Denegado',
        content:
            'Para seleccionar imágenes de los productos, debes habilitar el permiso de almacenamiento o fotos desde los ajustes del sistema.',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de almacenamiento/fotos denegado'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
    }
  }

  void _showPermissionDeniedDialog({
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.security_update_warning_rounded,
                color: Color(0xFFDC2626)),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 18))),
          ],
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _mediaService.openSettings();
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
            ),
            child: const Text('Abrir Ajustes'),
          ),
        ],
      ),
    );
  }

  void _showMediaSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cambiar foto del producto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Elige el origen para la nueva imagen de ${widget.item.codigoSku}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D9488).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Color(0xFF0D9488),
                    ),
                  ),
                  title: const Text(
                    'Tomar foto con Cámara',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Captura una imagen en tiempo real'),
                  onTap: _handleCameraSelection,
                ),
                const Divider(),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.photo_library_rounded,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  title: const Text(
                    'Elegir de Galería',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Selecciona una imagen guardada'),
                  onTap: _handleGallerySelection,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviewImage() {
    if (_customImageBytes != null) {
      return Image.memory(
        _customImageBytes!,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
      );
    }

    final url = _imagenSeleccionada ?? widget.item.imageUrl;

    Widget fallback(
            BuildContext context, Object error, StackTrace? stackTrace) =>
        Container(
          color: const Color(0xFFF1F5F9),
          child: const Center(
            child: Icon(
              Icons.inventory_2_rounded,
              size: 64,
              color: Color(0xFF94A3B8),
            ),
          ),
        );

    if (url != null &&
        (url.startsWith('http://') ||
            url.startsWith('https://') ||
            url.startsWith('blob:'))) {
      return Image.network(
        url,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        errorBuilder: fallback,
      );
    } else if (url != null && !kIsWeb) {
      return Image.file(
        File(url),
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        errorBuilder: fallback,
      );
    }

    return Container(
      color: const Color(0xFFF1F5F9),
      child: const Center(
        child: Icon(
          Icons.inventory_2_rounded,
          size: 64,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primarySlate = Color(0xFF0F172A);
    const secondaryTeal = Color(0xFF0D9488);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        _retrocederConResultado();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalle: ${widget.item.codigoSku}'),
          backgroundColor: primarySlate,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _retrocederConResultado,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              tooltip: 'Alerta de Stock Crítico',
              onPressed: _dispararAlertaStock,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vista previa de imagen del producto (dinámica)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey.shade100,
                      child: _buildPreviewImage(),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _customImageBytes != null ||
                                      _imagenSeleccionada !=
                                          widget.item.imageUrl
                                  ? Icons.verified_rounded
                                  : Icons.photo_camera_back_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _customImageBytes != null ||
                                      _imagenSeleccionada !=
                                          widget.item.imageUrl
                                  ? 'Foto personalizada'
                                  : 'Foto de catálogo',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Botón interactivo directo para cambiar foto
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _showMediaSourceBottomSheet,
                  icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                  label: const Text('Cambiar foto del producto'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primarySlate,
                    side: const BorderSide(color: primarySlate, width: 1.2),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Tarjeta destacada con datos principales
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.nombre,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primarySlate,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Categoría: ${widget.item.categoria}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Precio unitario: \$${widget.item.precio.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Información de existencias
              const Text(
                'Información de Existencias:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primarySlate,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    widget.item.stock > 5
                        ? Icons.check_circle_outline
                        : Icons.warning_amber_rounded,
                    color: widget.item.stock > 5 ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Unidades en bodega: ${widget.item.stock}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),

              const Divider(height: 32),

              // Observaciones de stock
              const Text(
                'Observaciones de Stock:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primarySlate,
                ),
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
        ),
      ),
    );
  }
}
