class TipoMultaModels {
  int? id_tipo_multa;
  String descripcion;
 
  // Constructor
  TipoMultaModels({
    this.id_tipo_multa,
    required this.descripcion, 
  });

  // Convertir de map a clase (SELECT)
  factory TipoMultaModels.fromMap(Map<String, dynamic> data) {
    return TipoMultaModels(
      id_tipo_multa: data["id_tipo_multa"],
      descripcion: data["descripcion"],
    );
  }

  // Convertir de clase a map (INSERT, UPDATE)
  Map<String, dynamic> toMap() {
    return {
      "id_tipo_multa": id_tipo_multa,
      "descripcion": descripcion,
    };
  }
}
