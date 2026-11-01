# StockFlow Pro - Evolución y Rebranding de Inventicy

> **Actividad Integradora 2** — Reingeniería de Software y Servicios Nativos  
> **Proyecto:** StockFlow Pro (v2.0.0)  
> **Autor:** Jeremy Molina Sánchez  
> **Carrera:** Ingeniería en Sistemas Inteligentes  
> **Asignatura:** Desarrollo de Aplicaciones Móviles  
> **Institución:** Universidad ECOTEC (2026)  
> **Docente:** Máster Gregorio Cruz G.  

---

## 📱 Descripción del Proyecto

**StockFlow Pro** representa la evolución y pivote de marca de la solución *Inventicy*. Es una aplicación móvil multiplataforma (Android, Web y Desktop) diseñada con **Material 3** para el control inteligente, catalogación y monitoreo de inventarios en bodegas comerciales e industriales. 

La versión **2.0.0** introduce un proceso integral de reingeniería arquitectónica, integrando acceso a hardware y servicios nativos del sistema operativo de manera reactiva, desacoplada y escalable.

---

## 🔄 Punto A: Resumen de Reingeniería y Rebranding Comercial

1. **Evolución de Marca e Identidad Visual (v2.0.0)**:
   - Transición del prototipo inicial *Inventicy* a la marca comercial **StockFlow Pro**.
   - Implementación de un sistema de diseño profesional en **Material 3** con paleta tonal corporativa:
     - **Azul Slate Corporativo (Primario):** `Color(0xFF0F172A)`
     - **Teal Industrial (Secundario):** `Color(0xFF0D9488)`
     - **Fondo Neutral Limpio:** `Color(0xFFF8FAFC)`
2. **Reconfiguración del Identificador Nativo (Android)**:
   - Actualización de `applicationId` y `namespace` a: `com.stockflow.pro` en `android/app/build.gradle.kts`.
   - Modificación del árbol de código fuente Kotlin a `android/app/src/main/kotlin/com/stockflow/pro/MainActivity.kt`.
   - Etiqueta comercial unificada `android:label="StockFlow Pro"` en `AndroidManifest.xml` y en manifiestos Web (`web/manifest.json` y `web/index.html`).
3. **Pantalla de Bienvenida (Splash Screen)**:
   - Nueva pantalla inicial en [`lib/screens/splash_screen.dart`](lib/screens/splash_screen.dart) con el logotipo institucional vectorial de StockFlow Pro, insignia `PRO`, subtítulo *"Control Inteligente de Inventario"* e indicador de versión `v2.0.0`.
   - Redirección automática no bloqueante tras 2 segundos hacia el catálogo principal ([`HomeScreen`](lib/screens/home_screen.dart)).

---

## ⚙️ Punto B: Módulo de Servicios Nativos Avanzados

El sistema implementa tres servicios desacoplados bajo el directorio `lib/services/`:

### 1. Conectividad Reactiva y Modo Offline (Punto B.1)
- **Servicio:** [`NetworkService`](lib/services/network_service.dart) implementado como un Singleton reactivo que escucha eventos de red en tiempo real mediante `connectivity_plus`.
- **Exposición de Estado:** Ofrece el estado inmediato (`isConnected`) y un flujo continuo (`isConnectedStream`) para reaccionar a cambios entre WiFi, datos móviles o desconexión.
- **Componente Visual:** [`OfflineBanner`](lib/widgets/offline_banner.dart), una barra flotante animada con `SizeTransition` que se despliega automáticamente en la parte superior del catálogo cuando se pierde la conexión (*"Sin conexión a internet - Modo sin conexión"*) y se oculta de forma fluida al restablecerse el enlace.

### 2. Acceso a Hardware: Cámara, Galería y Permisos Dinámicos (Punto B.2)
- **Servicio:** [`MediaService`](lib/services/media_service.dart) desacoplado para captura y selección de imágenes utilizando `image_picker` y `permission_handler`.
- **Permisos en Tiempo de Ejecución:** Evaluación dinámica de permisos con control de denegación (`CAMERA`, `READ_EXTERNAL_STORAGE` y `READ_MEDIA_IMAGES` para Android 13+ / API 33+), incluyendo diálogo guiado hacia los ajustes del dispositivo ante denegaciones permanentes.
- **Interacción en Detalle:** En [`DetailScreen`](lib/screens/detail_screen.dart), un botón interactivo y un botón flotante despliegan un `ModalBottomSheet` para elegir entre *"Tomar foto con Cámara"* o *"Elegir de Galería"*, actualizando de inmediato la vista previa del producto mediante bytes en memoria (`Uint8List`), asegurando compatibilidad multiplataforma transparente.

### 3. Notificaciones Locales y Alertas de Inventario (Punto B.3)
- **Servicio:** [`NotificationService`](lib/services/notification_service.dart) con soporte nativo mediante `flutter_local_notifications`.
- **Canal Nativo Android:**
  - **ID:** `stock_alerts_channel`
  - **Nombre:** `Alertas de Stock`
  - **Descripción:** `Notificaciones sobre novedades y existencias del inventario`
  - **Importancia:** `Importance.high` / `Priority.high`
- **Permisos de Notificación:** Solicitud en tiempo de ejecución para Android 13+ (`POST_NOTIFICATIONS`) e iOS (`solicitarPermisos()`).
- **Disparador en Pantalla de Detalle:** Incorporación del método `mostrarNotificacion(...)` vinculado a un botón interactivo de *"Disparar Alerta de Stock Crítico"* y a eventos de actualización de producto, alertando al usuario nativamente sobre existencias bajas en bodega.

---

## 🌿 Punto C: Estructura de Ramas y Flujo Git

El proyecto sigue una estrategia de ramificación estructurada para control de versiones:

* **Rama `Desarrollo`**:
  - Rama de trabajo activo donde se implementó la reingeniería de software completa de la Actividad Integradora 2.
  - Alberga las dependencias nativas (`connectivity_plus`, `image_picker`, `permission_handler`, `flutter_local_notifications`), los nuevos servicios modulares, componentes reactivos y la suite ampliada de pruebas.
* **Rama `main`**:
  - Rama principal de producción que aloja las versiones estables auditadas y consolidadas del sistema tras la aprobación de los entregables y pruebas de integración.

---

## 📂 Arquitectura Modular del Código (`lib/`)

```text
lib/
├── main.dart                       # Entrada de la app, tema Material 3 e inicialización global
├── models/
│   └── item_inventario.dart        # Entidad de dominio con soporte fromJson/toJson desacoplado
├── screens/
│   ├── splash_screen.dart          # Bienvenida con logotipo vectorial y temporizador seguro
│   ├── home_screen.dart            # Catálogo reactivo con banner de conectividad integrado
│   └── detail_screen.dart          # Detalle técnico, captura de fotos y alertas de stock
├── services/
│   ├── network_service.dart        # Monitoreo reactivo de conectividad (connectivity_plus)
│   ├── media_service.dart          # Cámara, galería y permisos dinámicos (image_picker + permission_handler)
│   └── notification_service.dart   # Canal nativo y emisión de notificaciones locales
└── widgets/
    ├── offline_banner.dart         # Banner animado flotante de estado sin conexión
    └── product_card.dart           # Tarjeta modular reutilizable de producto
```

---

## 🧪 Pruebas Automatizadas y Calidad de Código

El repositorio cuenta con una cobertura integral de pruebas unitarias y de widgets en `test/`:
* `test/item_inventario_test.dart`: Serialización y deserialización de modelos de datos.
* `test/product_card_test.dart`: Renderizado modular y eventos táctiles de tarjetas.
* `test/network_offline_banner_test.dart`: Reacción visual y flujos del banner de desconexión.
* `test/detail_media_test.dart`: Modal de cámara/galería y actualización de vista previa.
* `test/notification_service_test.dart`: Configuración del canal nativo de notificaciones y disparador de alerta.
* `test/widget_test.dart`: Flujo de navegación de extremo a extremo (`SplashScreen` → `HomeScreen` → `DetailScreen`).

**Estado de Auditoría:**
```bash
flutter analyze   # 0 advertencias / 0 errores de sintaxis
flutter test      # 10/10 pruebas unitarias y de integración aprobadas
```

---

## 🚀 Guía de Ejecución Local

### 1. Obtener dependencias del proyecto
```bash
flutter pub get
```

### 2. Ejecutar en dispositivo móvil físico o emulador (Android / iOS)
```bash
flutter run
```

### 3. Ejecutar en versión Web responsiva (Google Chrome / Edge)
```bash
flutter run -d chrome
```

### 4. Ejecutar la suite completa de pruebas automatizadas
```bash
flutter test
```

### 5. Análisis estático y verificación de estándares de código
```bash
flutter analyze
```
