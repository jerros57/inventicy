import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventicy/services/network_service.dart';
import 'package:inventicy/widgets/offline_banner.dart';

void main() {
  group('OfflineBanner Widget Tests', () {
    testWidgets('Muestra el banner cuando está desconectado (isOffline: true)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OfflineBanner(isOffline: true),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Sin conexión a internet - Modo sin conexión'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
    });

    testWidgets('Oculta el banner cuando está conectado (isOffline: false)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OfflineBanner(isOffline: false),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Sin conexión a internet - Modo sin conexión'),
        findsNothing,
      );
    });
  });

  group('NetworkService Unit Tests', () {
    test('emitStatusForTesting actualiza isConnected y emite en isConnectedStream',
        () async {
      final service = NetworkService();

      expectLater(
        service.isConnectedStream,
        emitsInOrder([false, true]),
      );

      service.emitStatusForTesting(false);
      expect(service.isConnected, false);

      service.emitStatusForTesting(true);
      expect(service.isConnected, true);
    });
  });
}

