import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  bool _isInitialized = false;

  NotificationService._internal(
      {FlutterLocalNotificationsPlugin? notificationsPlugin})
      : _notificationsPlugin =
            notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  /// Constructor para inyección de dependencias o pruebas unitarias
  NotificationService.withCustomPlugin(
      FlutterLocalNotificationsPlugin plugin)
      : _notificationsPlugin = plugin;

  /// Canal nativo para alertas de inventario en Android
  static const AndroidNotificationChannel stockAlertsChannel =
      AndroidNotificationChannel(
    'stock_alerts_channel',
    'Alertas de Stock',
    description: 'Notificaciones sobre novedades y existencias del inventario',
    importance: Importance.high,
  );

  bool get isInitialized => _isInitialized;

  /// Inicializa la configuración de notificaciones para Android e iOS
  Future<void> initialize() async {
    if (_isInitialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    try {
      await _notificationsPlugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          debugPrint('Notificación interactuada: ${response.payload}');
        },
      );

      // Crear canal nativo en Android
      final androidPlugin = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        await androidPlugin.createNotificationChannel(stockAlertsChannel);
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Error al inicializar NotificationService: $e');
    }
  }

  /// Solicita permisos de notificación en tiempo de ejecución (Android 13+ e iOS)
  Future<bool> solicitarPermisos() async {
    if (kIsWeb) return true;

    if (!_isInitialized) {
      await initialize();
    }
    if (!_isInitialized) return false;

    try {
      // Para Android 13+ (API 33+)
      final androidPlugin = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        final bool? granted =
            await androidPlugin.requestNotificationsPermission();
        return granted ?? false;
      }

      // Para iOS / macOS
      final iosPlugin = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (iosPlugin != null) {
        final bool? granted = await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }
    } catch (e) {
      debugPrint('Error al solicitar permisos de notificación: $e');
    }

    return true;
  }

  /// Dispara una notificación local inmediata
  Future<void> mostrarNotificacion({
    required String titulo,
    required String cuerpo,
    int id = 0,
    String? payload,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    final androidDetails = AndroidNotificationDetails(
      stockAlertsChannel.id,
      stockAlertsChannel.name,
      channelDescription: stockAlertsChannel.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _notificationsPlugin.show(
        id: id,
        title: titulo,
        body: cuerpo,
        notificationDetails: notificationDetails,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Error al mostrar notificación: $e');
    }
  }
}
