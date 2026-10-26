class ItemInventario {
  final String id;
  final String codigoSku;
  final String nombre;
  final String categoria;
  final int stock;
  final double precio;
  final String descripcion;

  const ItemInventario({
    required this.id,
    required this.codigoSku,
    required this.nombre,
    required this.categoria,
    required this.stock,
    required this.precio,
    required this.descripcion,
  });

  /// Factory desacoplado para deserialización de JSON (compatible con APIs REST).
  factory ItemInventario.fromJson(Map<String, dynamic> json) {
    return ItemInventario(
      id: json['id']?.toString() ?? '',
      codigoSku: json['codigoSku'] as String? ?? json['codigo_sku'] as String? ?? '',
      nombre: json['nombre'] as String? ?? '',
      categoria: json['categoria'] as String? ?? '',
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      precio: (json['precio'] as num?)?.toDouble() ?? 0.0,
      descripcion: json['descripcion'] as String? ?? '',
    );
  }

  /// Serialización a Map/JSON para peticiones REST o almacenamiento local.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigoSku': codigoSku,
      'nombre': nombre,
      'categoria': categoria,
      'stock': stock,
      'precio': precio,
      'descripcion': descripcion,
    };
  }
}
