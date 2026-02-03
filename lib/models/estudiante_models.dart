class EstudianteModels {
  int? id_estudiante;
  String cedula;
  String nombre;
  String apellido;
  String curso;
  String paralelo;

  // Constructor
  EstudianteModels({
    this.id_estudiante,
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.curso,
    required this.paralelo,
  });

  // Convertir de map a clase (SELECT)
  factory EstudianteModels.fromMap(Map<String, dynamic> data) {
    return EstudianteModels(
      id_estudiante: data["id_estudiante"],
      cedula: data["cedula"],
      nombre: data["nombre"],
      apellido: data["apellido"],
      curso: data["curso"],
      paralelo: data["paralelo"],
    );
  }

  // Convertir de clase a map (INSERT, UPDATE)
  Map<String, dynamic> toMap() {
    return {
      "id_estudiante": id_estudiante,
      "cedula": cedula,
      "nombre": nombre,
      "apellido": apellido,
      "curso": curso,
      "paralelo": paralelo,
    };
  }
}
