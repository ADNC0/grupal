import '/models/materia_models.dart';
import '/settings/database_connection.dart';


class MateriaRepository {
  final tableName = "materia";
  final database = DatabaseConnection();

  // funcion para insertar datos
  Future<int> create(MateriaModels data) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.insert(tableName, data.toMap()); // 2. ejecuto el sql
  }

  // funcion para editar datos
  Future<int> edit(MateriaModels data) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.update(
      tableName,
      data.toMap(),
      where: 'id_materia = ?',
      whereArgs: [data.id_materia],
    ); // 2. ejecuto el sql
  }

  // funcion para eliminar datos
  Future<int> delete(int id_materia) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.delete(
      tableName,
      where: 'id_materia = ?',
      whereArgs: [id_materia],
    ); // 2. ejecuto el sql
  }

  // funcion para listar datos
  Future<List<MateriaModels>> getAll() async {
    final db = await database.db; // 1. llamar a la conexion
    final response = await db.query(tableName); // 2. ejecuto el sql
    return response
        .map((e) => MateriaModels.fromMap(e))
        .toList(); // 3. transformar de json a clase
  }
}
