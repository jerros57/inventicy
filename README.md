# StockFlow Pro — MVP de Catálogo y Control de Inventario

[![Flutter](https://img.shields.io/badge/Flutter-3.47+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Material Design 3](https://img.shields.io/badge/Material_Design-3-795548?logo=materialdesign&logoColor=white)](https://m3.material.io/)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-dgv0mdsb-3448C5?logo=cloudinary&logoColor=white)](https://cloudinary.com)
[![Platform](https://img.shields.io/badge/Platforms-Android%20%7C%20Web%20%7C%20Windows-blue)](https://flutter.dev/multi-platform)

---

## 📋 Información Institucional y Autoría
* **Estudiante:** Jeremy Molina Sánchez
* **Carrera:** Ingeniería en Sistemas Inteligentes
* **Asignatura:** Desarrollo de Aplicaciones Móviles
* **Institución:** Universidad ECOTEC
* **Docente:** Máster Gregorio Cruz G.[cite: 8]
* **Repositorio Oficial:** [https://github.com/jerros57/inventicy](https://github.com/jerros57/inventicy)[cite: 8]

---

## 📱 Descripción del Proyecto
**StockFlow Pro** (evolución de *Inventicy*) es un prototipo interactivo (MVP) multiplataforma diseñado para la gestión y catalogación de productos en tiempo real. La solución implementa una arquitectura desacoplada y orientada a la experiencia de usuario (UX/UI), permitiendo la inspección detallada de existencias, la actualización de imágenes en caliente y la persistencia de estado entre pantallas mediante componentes de Google Material Design 3[cite: 8].

---

## 🛠️ Stack Tecnológico Utilizado
* **Framework:** [Flutter SDK (v3.47+)](https://flutter.dev) — Motor de renderizado reactivo y compilación multiplataforma[cite: 8].
* **Lenguaje:** [Dart (v3.13+)](https://dart.dev) — Lenguaje fuertemente tipado para la lógica de negocio y serialización de modelos[cite: 8].
* **Diseño UI:** Google Material Design 3 — Paleta cromática corporativa (Slate/Teal), tipografía estandarizada y ergonomía visual[cite: 8].
* **Entrega de Medios (CDN):** [Cloudinary](https://cloudinary.com) (Entorno: `dgv0mdsb`) — Infraestructura de distribución multimedia global[cite: 8].
* **Control de Versiones:** Git y GitHub — Gestión de ramas (`main` y `Desarrollo`), commits semánticos y trazabilidad auditable[cite: 8].
* **Calidad de Software:** `flutter test` y `flutter analyze` — Pruebas unitarias de widgets y análisis estático con 0 errores y 0 advertencias[cite: 9, 11].

---

## ☁️ Integración de Activos Digitales con Cloudinary CDN
Para evitar el uso de imágenes genéricas locales o estáticas y simular un entorno comercial real, **StockFlow Pro** consume sus recursos gráficos a través de la infraestructura en la nube de **Cloudinary** (Cloud Name: `dgv0mdsb`)[cite: 8]:

* **Distribución de Baja Latencia:** Recursos servidos mediante CDN global para acelerar la carga en dispositivos móviles y navegadores web[cite: 8].
* **Transformación y Optimización Dinámica:** Enlaces configurados con directivas `c_fill,w_300,h_300,q_auto,f_auto` para adaptar dimensiones, formato y tasa de compresión automáticamente según la resolución de la pantalla[cite: 8].
* **Tolerancia a Fallos:** Manejo de excepciones visuales con `errorBuilder` dentro de `ClipRRect`, mostrando iconos contextuales en caso de interrupción de red[cite: 11].

---

## 🏛️ Arquitectura Modular del Sistema
El código fuente en `lib/` mantiene una estricta separación de responsabilidades[cite: 8]:

```text
lib/
├── models/
│   └── item_inventario.dart    # Entidad de dominio con soporte fromJson/toJson y copyWith
├── screens/
│   ├── home_screen.dart        # Vista principal del catálogo con barra y lista dinámica
│   └── detail_screen.dart      # Vista detallada de existencias, precio y selector de fotos
├── widgets/
│   └── product_card.dart       # Componente reutilizable con soporte Image.network y eventos
└── main.dart                   # Punto de entrada y configuración de tema Material 3