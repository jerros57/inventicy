# Inventicy - MVP Catálogo y Control de Inventario

> **Actividad Integradora 1** — Desarrollo de Aplicaciones Móviles  
> **Institución:** Universidad ECOTEC (2026)  
> **Carrera:** Ingeniería en Sistemas Inteligentes  
> **Autor:** Jeremy Molina Sánchez  

---

## 📱 Descripción del Proyecto

**Inventicy** es un prototipo interactivo (MVP) multiplataforma (Web y Móvil) desarrollado en **Flutter** con diseño corporativo basado en **Material 3** (paleta tonal Índigo). Su objetivo es proporcionar una solución ágil y moderna para la catalogación, consulta técnica de existencias y control de inventario de productos.

---

## 🏛️ Arquitectura de Software Modular

El proyecto implementa una arquitectura desacoplada y organizada en capas bajo el directorio `lib/`:

* **`lib/models/`**:
  * [`item_inventario.dart`](file:///c:/dev/inventicy/lib/models/item_inventario.dart): Entidad de dominio `ItemInventario` con atributos de negocio (`id`, `codigoSku`, `nombre`, `categoria`, `stock`, `precio`, `descripcion`). Diseñada de manera desacoplada con el constructor factory `ItemInventario.fromJson()` y método `toJson()`, garantizando interoperabilidad inmediata con futuras APIs REST y servicios backend.
* **`lib/screens/`**:
  * [`home_screen.dart`](file:///c:/dev/inventicy/lib/screens/home_screen.dart): Catálogo interactivo de productos. Implementa obligatoriamente la jerarquía de widgets: `AppBar` accesible con acciones semánticas, `ListView.builder`, `Card`, `Container`, `Row`, `Column`, `Text`, `Icon` y botón interactivo (`FilledButton.tonalIcon` / `InkWell`).
  * [`detail_screen.dart`](file:///c:/dev/inventicy/lib/screens/detail_screen.dart): Pantalla de detalle que recibe obligatoriamente la instancia tipada de `ItemInventario`. Presenta tarjeta destacada con precio unitario, indicador visual de existencias en bodega y observaciones de stock.
* **`lib/widgets/`**:
  * Estructura modular preparada para la extracción y desacoplamiento de componentes de interfaz reutilizables (tarjetas de producto, badges de inventario y diálogos informativos).

---

## 🔄 Flujo de Navegación y Paso de Parámetros

1. **Navegación hacia Adelante (`Navigator.push`)**:
   Al seleccionar un producto desde el catálogo (ya sea presionando el botón *"Ver detalles"* o pulsando sobre la tarjeta), se ejecuta un `Navigator.push` utilizando `MaterialPageRoute`, inyectando la instancia del modelo `ItemInventario` seleccionado hacia el constructor de `DetailScreen`.
2. **Retorno Seguro (`Navigator.pop`)**:
   El `AppBar` de `DetailScreen` dispone de un botón de acción retroceso (`Icons.arrow_back`) que invoca `Navigator.pop(context)`, liberando la ruta de la pila y devolviendo al usuario al estado actual del catálogo.

---

## 🧪 Pruebas Automatizadas y Calidad de Código

El proyecto cuenta con validación estricta de análisis estático y pruebas automatizadas:

* **Pruebas de Serialización**: Validación unitaria de deserialización (`fromJson`) y serialización (`toJson`) en [`test/item_inventario_test.dart`](file:///c:/dev/inventicy/test/item_inventario_test.dart).
* **Pruebas de Widget e Integración**: Smoke test y prueba de flujo completo de navegación catálogo -> detalle -> retorno en [`test/widget_test.dart`](file:///c:/dev/inventicy/test/widget_test.dart).
* **Estado de Verificación**:
  * `flutter analyze`: **0 advertencias / 0 errores**.
  * `flutter test`: **100% de pruebas aprobadas**.

---

## 🚀 Instrucciones de Ejecución Local

### Prerrequisitos
Tener instalado el SDK de Flutter (versión 3.x o superior) y las extensiones correspondientes.

### Comandos de Ejecución

```bash
# Obtener dependencias
flutter pub get

# Ejecución en Navegador Web (Google Chrome / Edge)
flutter run -d chrome

# Ejecución en dispositivo móvil o emulador (Android / iOS)
flutter run

# Ejecución del suite de pruebas automatizadas
flutter test

# Análisis estático de código
flutter analyze
```
