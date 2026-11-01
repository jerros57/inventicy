import 'package:flutter/material.dart';
import '../services/network_service.dart';

class OfflineBanner extends StatelessWidget {
  /// Permite forzar el estado externamente para pruebas o control manual.
  final bool? isOffline;

  /// Mensaje descriptivo a mostrar en el banner.
  final String message;

  const OfflineBanner({
    super.key,
    this.isOffline,
    this.message = 'Sin conexión a internet - Modo sin conexión',
  });

  @override
  Widget build(BuildContext context) {
    if (isOffline != null) {
      return _buildAnimatedBanner(isOffline!);
    }

    // Por defecto escucha en tiempo real al NetworkService desacoplado
    return StreamBuilder<bool>(
      stream: NetworkService().isConnectedStream,
      initialData: NetworkService().isConnected,
      builder: (context, snapshot) {
        final connected = snapshot.data ?? true;
        final offline = !connected;
        return _buildAnimatedBanner(offline);
      },
    );
  }

  Widget _buildAnimatedBanner(bool show) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          alignment: Alignment.topCenter,
          child: child,
        );
      },
      child: show
          ? Container(
              key: const ValueKey('offline_banner_visible'),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFDC2626), // Rojo advertencia corporativo
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFDC2626).withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.wifi_off_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(key: ValueKey('offline_banner_hidden')),
    );
  }
}
