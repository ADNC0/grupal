import 'package:flutter/material.dart';

import '../../models/tipo_multa_models.dart';
import '../../repositories/tipo_multa_repository.dart';

class TipoMultaScreen extends StatefulWidget {
  const TipoMultaScreen({super.key});

  @override
  State<TipoMultaScreen> createState() => _TipoMultaScreenState();
}

class _TipoMultaScreenState extends State<TipoMultaScreen> {
  final TipoMultaRepository repo = TipoMultaRepository();

  List<TipoMultaModels> tipoMultas = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarTipoMulta();
  }

  Future<void> cargarTipoMulta() async {
    setState(() => cargando = true);
    tipoMultas = await repo.getAll(); // consultar el listado
    setState(() => cargando = false);
  }

  void  eliminarTipoMulta(int id_tipo){
    //aqui va la logica del modal
    showDialog(
      context: context, 
      builder: (_)=> AlertDialog(
        title: Text("Eliminar Tipo de Multa"),
        content: Text("¿Estás seguro que deseas eliminar este registro?"),
        actions: [
          TextButton(onPressed: () async{
            await repo.delete(id_tipo);
            Navigator.pop(context);
            cargarTipoMulta();
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
      appBar: AppBar(title: Text("Listado de tipos de multa")),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : tipoMultas.isEmpty
          ? Center(child: Text("No existen datos"))
          : ListView.builder(
              itemCount: tipoMultas.length,
              itemBuilder: (context, i) {
                final tipoMulta = tipoMultas[i];
                return Card(
                  child: ListTile(
                    title: Text(tipoMulta.descripcion),
                    subtitle: Text(tipoMulta.gravedad),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () async {
                          await Navigator.pushNamed(
                            context
                            , '/tipo_multa/form',
                            arguments: tipoMulta,
                            ); 
                            cargarTipoMulta();
                        }, 
                        icon: Icon(Icons.edit, color: Colors.orange,)),
                        IconButton(
                          onPressed: () => eliminarTipoMulta(tipoMulta.id_tipo!), 
                          icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/tipo_multa/form');
          cargarTipoMulta();
        },
        backgroundColor: Colors.black,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}