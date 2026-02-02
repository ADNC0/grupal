import '/models/multa_models.dart';
import '/settings/database_connection.dart';

class MultaRepository {
  final tableName = "multa";
  final database = DatabaseConnection();

  // insertar multa
  Future<int> create(MultaModels data) async {
    final db = await database.db;
    return await db.insert(tableName, data.toMap());
  }

  // editar multa
  Future<int> edit(MultaModels data) async {
    final db = await database.db;
    return await db.update(
      tableName,
      data.toMap(),
      where: 'id_multa = ?',
      whereArgs: [data.id_multa],
    );
  }

  // eliminar multa
  Future<int> delete(int id_multa) async {
    final db = await database.db;
    return await db.delete(
      tableName,
      where: 'id_multa = ?',
      whereArgs: [id_multa],
    );
  }

  //listar multas
  Future<List<MultaModels>> getAll() async {
  final db = await database.db;
  final response = await db.query(tableName);
  return response
  .map((e) => MultaModels.fromMap(e))
  .toList();
  }


}
