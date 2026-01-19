import '/models/tipo_multa_models.dart';
import '/settings/database_connection.dart';


class TipoMultaRepository {
  final tableName = "tipo_multa";
  final database = DatabaseConnection();

  // funcion para insertar datos
  Future<int> create(TipoMultaModels data) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.insert(tableName, data.toMap()); // 2. ejecuto el sql
  }

  // funcion para editar datos
  Future<int> edit(TipoMultaModels data) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.update(
      tableName,
      data.toMap(),
      where: 'id_tipo = ?',
      whereArgs: [data.id_tipo],
    ); // 2. ejecuto el sql
  }

  // funcion para eliminar datos
  Future<int> delete(int id_tipo) async {
    final db = await database.db; // 1. llamar a la conexion
    return await db.delete(
      tableName,
      where: 'id_tipo = ?',
      whereArgs: [id_tipo],
    ); // 2. ejecuto el sql
  }

  // funcion para listar datos
  Future<List<TipoMultaModels>> getAll() async {
    final db = await database.db; // 1. llamar a la conexion
    final response = await db.query(tableName); // 2. ejecuto el sql
    return response
        .map((e) => TipoMultaModels.fromMap(e))
        .toList(); // 3. transformar de json a clase
  }
}
