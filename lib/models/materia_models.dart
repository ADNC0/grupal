class MateriaModels {
  int? id_materia;
  String nombre;
 
  // Constructor
  MateriaModels({
    this.id_materia,
    required this.nombre, 
  });

  // Convertir de map a clase (SELECT)
  factory MateriaModels.fromMap(Map<String, dynamic> data) {
    return MateriaModels(
      id_materia: data["id_materia"],
      nombre: data["nombre"],
    );
  }

  // Convertir de clase a map (INSERT, UPDATE)
  Map<String, dynamic> toMap() {
    return {
      "id_materia": id_materia,
      "nombre": nombre,
    };
  }
}
