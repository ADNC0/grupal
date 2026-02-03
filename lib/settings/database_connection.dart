import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  // Generando un constructor para el llamado
  static final DatabaseConnection instance = DatabaseConnection.internal();
  factory DatabaseConnection() => instance;

  // referencias internas
  DatabaseConnection.internal();

  // crear un llamado de la libreria sqflite
  static Database? database;

  // funcion para crear la conexion
  Future<Database> get db async {
    // retorna la conexion si ya existia una antes
    if (database != null) return database!;
    database = await inicializarDb(); // inicializa la conexion en la funcion
    return database!; // retorna la conexion con la nueva conexion
  }

  Future<Database> inicializarDb() async {
    final rutaDb = await getDatabasesPath();
    final rutaFinal = join(
      rutaDb,
      'gestion.db',
    );

    return await openDatabase(
      rutaFinal,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE estudiante (
            id_estudiante INTEGER PRIMARY KEY AUTOINCREMENT,
            cedula TEXT,
            nombre TEXT,
            apellido TEXT,
            curso TEXT,
            paralelo TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE materia (
            id_materia INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            docente TEXT,
            estado TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE tipo_multa (
            id_tipo INTEGER PRIMARY KEY AUTOINCREMENT,
            descripcion TEXT,
            gravedad TEXT,
            estado TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE multa (
            id_multa INTEGER PRIMARY KEY AUTOINCREMENT,
            fecha TEXT,
            valor TEXT,
            id_estudiante INTEGER,
            nombre_estudiante TEXT,
            id_materia INTEGER,
            id_tipo INTEGER
          )
        ''');
      },
    );
  }
}
