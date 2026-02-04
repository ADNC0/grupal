import 'package:flutter/material.dart';

import '../../models/materia_models.dart';
import '../../repositories/materia_repository.dart';

class MateriaScreen extends StatefulWidget {
  const MateriaScreen({super.key});

  @override
  State<MateriaScreen> createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  final MateriaRepository repo = MateriaRepository();

  List<MateriaModels> materias = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarMateria();
  }

  Future<void> cargarMateria() async {
    setState(() => cargando = true);
    materias = await repo.getAll(); // consultar el listado
    setState(() => cargando = false);
  }

  void  eliminarMateria(int id_materia){
    //aqui va la logica del modal
    showDialog(
      context: context, 
      builder: (_)=> AlertDialog(
        title: Text("Eliminar Materia"),
        content: Text("¿Estás seguro que deseas eliminar este registro?"),
        actions: [
          TextButton(onPressed: () async{
            await repo.delete(id_materia);
            Navigator.pop(context);
            cargarMateria();
          }, child: Text("Si")),
          TextButton(onPressed: () {
            Navigator.pop(context);
            }, child: Text("No")),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listado de materias")),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : materias.isEmpty
          ? Center(child: Text("No existen datos"))
          : ListView.builder(
              itemCount: materias.length,
              itemBuilder: (context, i) {
                final materia = materias[i];
                return Card(
                  child: ListTile(
                    title: Text(materia.nombre),
                    subtitle: Text('${materia.docente} - ${materia.estado}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () async {
                          await Navigator.pushNamed(
                            context
                            , '/materia/form',
                            arguments: materia,
                            ); 
                            cargarMateria();
                        }, 
                        icon: Icon(Icons.edit, color: Colors.orange,)),
                        IconButton(
                          onPressed: () => eliminarMateria(materia.id_materia!), 
                          icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/materia/form');
          cargarMateria();
        },
        backgroundColor: Colors.redAccent,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}