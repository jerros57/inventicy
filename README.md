# Inventicy - MVP Catálogo y Gestión de Inventario

**Autor:** Jeremy Molina Sánchez  
**Carrera:** Ingeniería en Sistemas Inteligentes  
**Materia:** Desarrollo de Aplicaciones Móviles  

---

## 📱 Descripción del Proyecto
Inventicy es un prototipo interactivo (MVP) multiplataforma (Web y Móvil) desarrollado con Flutter para la catalogación y control ágil de inventario de productos.

## 🏛️ Estructura Modular (`lib/`)
* `lib/models/`: Entidad `ItemInventario` desacoplada con soporte `fromJson` para facilitar el consumo de APIs REST a futuro.
* `lib/screens/`: 
  * `home_screen.dart`: Catálogo visual con tarjetas informativas y botones interactivos.
  * `detail_screen.dart`: Visualización técnica de existencias y detalle de producto.

## 🚀 Ejecución Local
```bash
# Para web
flutter run -d chrome

# Para móvil / emulador
flutter run
```
