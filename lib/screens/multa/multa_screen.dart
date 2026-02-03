import 'package:flutter/material.dart';

import '../../models/multa_models.dart';
import '../../repositories/multa_repository.dart';

class MultaScreen extends StatefulWidget {
  const MultaScreen({super.key});

  @override
  State<MultaScreen> createState() => _MultaScreenState();
}

class _MultaScreenState extends State<MultaScreen> {
  final MultaRepository repo = MultaRepository();

  List<MultaModels> multas = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarMultas();
  }

  Future<void> cargarMultas() async {
    setState(() => cargando = true);
    multas = await repo.getAll();
    setState(() => cargando = false);
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
                        title: Text(multa.fecha),
                        leading: Text('${multa.id_estudiante} - ${multa.nombre_estudiante}'),
                        subtitle: Text(multa.valor),
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
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
