class ItemInventario {
  final String id;
  final String codigoSku;
  final String nombre;
  final String categoria;
  final int stock;
  final double precio;
  final String descripcion;
  final String? imageUrl;

  const ItemInventario({
    required this.id,
    required this.codigoSku,
    required this.nombre,
    required this.categoria,
    required this.stock,
    required this.precio,
    required this.descripcion,
    this.imageUrl,
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
      imageUrl: json['imageUrl'] as String? ?? json['image_url'] as String?,
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
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  /// Genera una copia de la entidad modificando únicamente los campos especificados.
  ItemInventario copyWith({
    String? id,
    String? codigoSku,
    String? nombre,
    String? categoria,
    int? stock,
    double? precio,
    String? descripcion,
    String? imageUrl,
  }) {
    return ItemInventario(
      id: id ?? this.id,
      codigoSku: codigoSku ?? this.codigoSku,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      stock: stock ?? this.stock,
      precio: precio ?? this.precio,
      descripcion: descripcion ?? this.descripcion,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
