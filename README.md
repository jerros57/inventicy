# Inventicy - MVP Catálogo y Gestión de Inventario Multiplataforma

**Estudiante:** Jeremy Molina Sánchez  
**Carrera:** Ingeniería en Sistemas Inteligentes  
**Asignatura:** Desarrollo de Aplicaciones Móviles  
**Docente:** Máster Gregorio Cruz G.  

---

## 📱 Descripción del Proyecto
**Inventicy** es un prototipo interactivo (MVP) multiplataforma (Web, Móvil Android y Escritorio Windows ARM64) desarrollado en **Flutter (Dart)** para la catalogación y control ágil de inventario de productos. Su arquitectura está desacoplada y preparada para futuras integraciones con servicios externos mediante API REST.

## 🏛️ Estructura Modular y Componentes (`lib/`)
* `lib/models/`: Contiene la entidad fuertemente tipada `ItemInventario` con el método constructor `.fromJson()` para consumo futuro de datos remotos.
* `lib/screens/`: 
  * `home_screen.dart`: Pantalla principal de catálogo con componentes Material Design 3.
  * `detail_screen.dart`: Pantalla de detalle técnico y existencias con paso de parámetros por constructor.
* `lib/widgets/`: 
  * `product_card.dart`: Componente reutilizable optimizado para la renderización de tarjetas de producto con imágenes en red (`Image.network`) y manejo de estados de stock.

## 🔄 Flujo de Navegación y Pruebas
* **Navegación:** Implementación del flujo de ida y vuelta mediante `Navigator.push` (con inyección de objetos tipados a través de `MaterialPageRoute`) y retorno con `Navigator.pop`.
* **Calidad de Software:** Validación automatizada de widgets y análisis sintáctico mediante `flutter test` y `flutter analyze` sin errores ni advertencias.

## 🚀 Instrucciones de Ejecución Local
```bash
# Ejecutar en navegador web
flutter run -d chrome

# Ejecutar en emulador o dispositivo físico Android
flutter run
```

## 🔌 Escalabilidad y Conexión API REST (Arquitectura Futura)
El diseño desacoplado permite la sincronización con endpoints backend en una fase posterior sin alterar la capa de presentación de la interfaz de usuario.