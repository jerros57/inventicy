import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/models/item_inventario.dart';
import 'package:inventicy/screens/detail_screen.dart';
import 'package:inventicy/services/notification_service.dart';

void main() {
  const testItem = ItemInventario(
    id: 'test-notif-1',
    codigoSku: 'SKU-NOTIF-01',
    nombre: 'Monitor Gamer 144Hz',
    categoria: 'Monitores',
    stock: 2,
    precio: 249.99,
    descripcion: 'Monitor para pruebas de alertas de stock crítico.',
  );

  group('NotificationService Configuration Tests', () {
    test('Canal de notificaciones stockAlertsChannel está correctamente configurado', () {
      const channel = NotificationService.stockAlertsChannel;

      expect(channel.id, 'stock_alerts_channel');
      expect(channel.name, 'Alertas de Stock');
      expect(
        channel.description,
        'Notificaciones sobre novedades y existencias del inventario',
      );
      expect(channel.importance, Importance.high);
    });
  });

  group('DetailScreen Notification Trigger Tests', () {
    testWidgets('DetailScreen muestra botón de alerta y reacciona al tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DetailScreen(item: testItem),
        ),
      );

      // Verifica la existencia del botón de alerta de stock crítico
      final alertButton = find.widgetWithText(
        FilledButton,
        'Disparar Alerta de Stock Crítico',
      );
      expect(alertButton, findsOneWidget);

      // Verifica los iconos de alerta en AppBar y botón
      final appBarIcon = find.byIcon(Icons.notifications_active_outlined);
      expect(appBarIcon, findsNWidgets(2));

      // Desplaza hasta el botón si está fuera de pantalla y realiza tap
      await tester.ensureVisible(alertButton);
      await tester.tap(alertButton);
      await tester.pumpAndSettle();

      // Confirma que se muestra el SnackBar de confirmación
      expect(
        find.text('Notificación de alerta enviada al sistema nativo'),
        findsOneWidget,
      );
    });
  });
}
