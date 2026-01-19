class TipoMultaModels {
  int? id_tipo;
  String descripcion;
  String gravedad;
  String estado;
 
  // Constructor
  TipoMultaModels({
    this.id_tipo,
    required this.descripcion,
    required this.gravedad,
    required this.estado, 
  });

  // Convertir de map a clase (SELECT)
  factory TipoMultaModels.fromMap(Map<String, dynamic> data) {
    return TipoMultaModels(
      id_tipo: data["id_tipo"],
      descripcion: data["descripcion"],
      gravedad: data["gravedad"],
      estado: data["estado"],
    );
  }

  // Convertir de clase a map (INSERT, UPDATE)
  Map<String, dynamic> toMap() {
    return {
      "id_tipo": id_tipo,
      "descripcion": descripcion,
      "gravedad": gravedad,
      "estado": estado,
    };
  }
}
