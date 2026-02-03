import 'package:flutter/material.dart';

import '../../models/estudiante_models.dart';
import '../../repositories/estudiante_repository.dart';

class EstudianteScreen extends StatefulWidget {
  const EstudianteScreen({super.key});

  @override
  State<EstudianteScreen> createState() => _EstudianteScreenState();
}

class _EstudianteScreenState extends State<EstudianteScreen> {
  final EstudianteRepository repo = EstudianteRepository();

  List<EstudianteModels> estudiantes = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarEstudiante();
  }

  Future<void> cargarEstudiante() async {
    setState(() => cargando = true);
    estudiantes = await repo.getAll(); // consultar el listado
    setState(() => cargando = false);
  }

  void  eliminarEstudiante(int id){
    //aqui va la logica del modal
    showDialog(
      context: context, 
      builder: (_)=> AlertDialog(
        title: Text("Eliminar Estudiante"),
        content: Text("¿Estás seguro que deseas eliminar este registro?"),
        actions: [
          TextButton(onPressed: () async{
            await repo.delete(id);
            Navigator.pop(context);
            cargarEstudiante();
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
      appBar: AppBar(title: Text("Listado de estudiante")),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : estudiantes.isEmpty
          ? Center(child: Text("No existen datos"))
          : ListView.builder(
              itemCount: estudiantes.length,
              itemBuilder: (context, i) {
                final estudiante = estudiantes[i];
                return Card(
                  child: ListTile(
                    title: Text('${estudiante.nombre} ${estudiante.apellido}'),
                    subtitle: Text('${estudiante.curso} - ${estudiante.paralelo} - ${estudiante.cedula}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () async {
                          await Navigator.pushNamed(
                            context
                            , '/estudiante/form',
                            arguments: estudiante,
                            ); 
                            cargarEstudiante();
                        }, 
                        icon: Icon(Icons.edit, color: Colors.orange,)),
                        IconButton(
                          onPressed: () => eliminarEstudiante(estudiante.id_estudiante!), 
                          icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/estudiante/form');
          cargarEstudiante();
        },
        backgroundColor: Colors.black,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}