class EstudianteModels {
  int? id_estudiante;
  String nombre;
  String curso;
  String paralelo;

  // Constructor
  EstudianteModels({
    this.id_estudiante,
    required this.nombre,
    required this.curso,
    required this.paralelo,
  });

  // Convertir de map a clase (SELECT)
  factory EstudianteModels.fromMap(Map<String, dynamic> data) {
    return EstudianteModels(
      id_estudiante: data["id_estudiante"],
      nombre: data["nombre"],
      curso: data["curso"],
      paralelo: data["paralelo"],
    );
  }

  // Convertir de clase a map (INSERT, UPDATE)
  Map<String, dynamic> toMap() {
    return {
      "id_estudiante": id_estudiante,
      "nombre": nombre,
      "curso": curso,
      "paralelo": paralelo,
    };
  }
}
