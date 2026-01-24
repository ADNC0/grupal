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
    multas = await repo.getAll(); // consultar el listado
    setState(() => cargando = false);
  }

  void  eliminarMulta(int id_multa){
    //aqui va la logica del modal
    showDialog(
      context: context, 
      builder: (_)=> AlertDialog(
        title: Text("Eliminar Multa"),
        content: Text("¿Estás seguro que deseas eliminar este registro?"),
        actions: [
          TextButton(onPressed: () async{
            await repo.delete(id_multa);
            if (mounted) {
              Navigator.pop(context);
              cargarMultas();
            }
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
      appBar: AppBar(title: Text("Listado de multas")),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : multas.isEmpty
          ? Center(child: Text("No existen datos"))
          : ListView.builder(
              itemCount: multas.length,
              itemBuilder: (context, i) {
                final multa = multas[i];
                return Card(
                  child: ListTile(
                    title: Text(multa.fecha),
                    subtitle: Text(multa.valor),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () async {
                          await Navigator.pushNamed(
                            context
                            , '/multa/form',
                            arguments: multa,
                            ); 
                            cargarMultas();
                        }, 
                        icon: Icon(Icons.edit, color: Colors.orange,)),
                        IconButton(
                          onPressed: () => eliminarMulta(multa.id_multa!), 
                          icon: Icon(Icons.delete, color: Colors.red,)),
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
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}