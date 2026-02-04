import 'package:flutter/material.dart';

import '../../models/estudiante_models.dart';
import '../../models/materia_models.dart';
import '../../models/multa_models.dart';
import '../../models/tipo_multa_models.dart';
import '../../repositories/estudiante_repository.dart';
import '../../repositories/materia_repository.dart';
import '../../repositories/multa_repository.dart';
import '../../repositories/tipo_multa_repository.dart';

class MultaScreen extends StatefulWidget {
  const MultaScreen({super.key});

  @override
  State<MultaScreen> createState() => _MultaScreenState();
}

class _MultaScreenState extends State<MultaScreen> {
  final MultaRepository repo = MultaRepository();

  List<MultaModels> multas = [];
  List<EstudianteModels> estudiantes = [];
  List<MateriaModels> materias = [];
  List<TipoMultaModels> tipos = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarMultas();
  }

Future<void> cargarMultas() async {
  setState(() => cargando = true);

  multas = await repo.getAll();
  estudiantes = await EstudianteRepository().getAll();
  materias = await MateriaRepository().getAll();
  tipos = await TipoMultaRepository().getAll();

  setState(() => cargando = false);
}

String obtenerNombreEstudiante(int id) {
  for (final e in estudiantes) {
    if (e.id_estudiante == id) {
      return '${e.nombre} ${e.apellido}';
    }
  }
  return 'Desconocido';
}


String obtenerNombreMateria(int id) {
  for (final m in materias) {
    if (m.id_materia == id) {
      return m.nombre;
    }
  }
  return 'Desconocida';
}

String obtenerTipoMulta(int id) {
  for (final t in tipos) {
    if (t.id_tipo == id) {
      return t.descripcion;
    }
  }
  return 'N/A';
}

  void eliminarMulta(int id_multa) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar Multa"),
        content: const Text("¿Estás seguro que deseas eliminar este registro?"),
        actions: [
          TextButton(
            onPressed: () async {
              await repo.delete(id_multa);
              if (mounted) {
                Navigator.pop(context);
                cargarMultas();
              }

              
            },
            child: const Text("Si"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado de multas")),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : multas.isEmpty
              ? const Center(child: Text("No existen datos"))
              : ListView.builder(
                  itemCount: multas.length,
                  itemBuilder: (context, i) {
                    final multa = multas[i];
                    return Card(
                      child: ListTile(
                        title: Text('${obtenerNombreEstudiante(multa.id_estudiante)} - ${obtenerNombreMateria(multa.id_materia)}'),
                        subtitle: Text('${obtenerTipoMulta(multa.id_tipo)} | ''${multa.valor} | ${multa.fecha}',
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () async {
                                await Navigator.pushNamed(
                                  context,
                                  '/multa/form',
                                  arguments: multa,
                                );
                                cargarMultas();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  eliminarMulta(multa.id_multa!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/multa/form');
          cargarMultas();
        },
        backgroundColor: Colors.deepOrangeAccent,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

