class MultaModels {
  int? id_multa;
  String fecha;
  String valor;
  int id_estudiante;
  int id_materia;
  int id_tipo;

  // Constructor
  MultaModels({
    this.id_multa,
    required this.fecha,
    required this.valor,
    required this.id_estudiante,
    required this.id_materia,
    required this.id_tipo,
  });

  // Convertir de map a clase (SELECT)
  factory MultaModels.fromMap(Map<String, dynamic> data) {
    return MultaModels(
      id_multa: data["id_multa"],
      fecha: data["fecha"],
      valor: data["valor"],
      id_estudiante: data["id_estudiante"],
      id_materia: data["id_materia"],
      id_tipo: data["id_tipo"],
    );
  }

  // Convertir de clase a map (INSERT, UPDATE)
  Map<String, dynamic> toMap() {
    return {
      "id_multa": id_multa,
      "fecha": fecha,
      "valor": valor,
      "id_estudiante": id_estudiante,
      "id_materia": id_materia,
      "id_tipo": id_tipo,
    };
  }
}
