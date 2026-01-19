import '/models/estudiante_models.dart';
import '/settings/database_connection.dart';


class EstudianteRepository {
  final tableName = "estudiante";
  final database = DatabaseConnection();

  // funcion para insertar datos
  Future<int> create(EstudianteModels data) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.insert(tableName, data.toMap()); // 2. ejecuto el sql
  }

  // funcion para editar datos
  Future<int> edit(EstudianteModels data) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.update(
      tableName,
      data.toMap(),
      where: 'id_estudiante = ?',
      whereArgs: [data.id_estudiante],
    ); // 2. ejecuto el sql
  }

  // funcion para eliminar datos
  Future<int> delete(int id_estudiante) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.delete(
      tableName,
      where: 'id_estudiante = ?',
      whereArgs: [id_estudiante],
    ); // 2. ejecuto el sql
  }

  // funcion para listar datos
  Future<List<EstudianteModels>> getAll() async {
    final db = await database.db; // 1. llamar a la conexion
    final response = await db.query(tableName); // 2. ejecuto el sql
    return response
        .map((e) => EstudianteModels.fromMap(e))
        .toList(); // 3. transformar de json a clase
  }
}
