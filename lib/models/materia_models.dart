class MateriaModels {
  int? id_materia;
  String nombre;
  String? docente;
  String? estado;
 
  // Constructor
  MateriaModels({
    this.id_materia,
    required this.nombre, 
    this.docente,
    this.estado,
  });

  // Convertir de map a clase (SELECT)
  factory MateriaModels.fromMap(Map<String, dynamic> data) {
    return MateriaModels(
      id_materia: data["id_materia"],
      nombre: data["nombre"],
      docente: data["docente"],
      estado: data["estado"],
    );
  }

  // Convertir de clase a map (INSERT, UPDATE)
  Map<String, dynamic> toMap() {
    return {
      "id_materia": id_materia,
      "nombre": nombre,
      "docente": docente,
      "estado": estado,
    };
  }
}
