import 'package:flutter/material.dart';

import '../../models/materia_models.dart';
import '../../repositories/materia_repository.dart';

class MateriaFormScreen extends StatefulWidget {
  const MateriaFormScreen({super.key});

  @override
  State<MateriaFormScreen> createState() => _MateriaFormScreenState();
}

class _MateriaFormScreenState extends State<MateriaFormScreen> {
  final formMateria = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final docenteController = TextEditingController();
  final estadoController = TextEditingController();
  MateriaModels? materia;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      materia = args as MateriaModels;
      nombreController.text = materia!.nombre;
      docenteController.text = materia!.docente;
      estadoController.text = materia!.estado;
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEditar = materia != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ? "editar materia" : "insertar materia"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formMateria,
          child: Column(
            children: [
              TextFormField(
                controller: nombreController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nombre",
                  hintText: "Ingrese el nombre de la materia",
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: docenteController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El docente es requerido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Docente",
                  hintText: "Ingrese el nombre del docente",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: estadoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El estado es requerido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Estado",
                  hintText: "Ingrese el estado de la materia",
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (formMateria.currentState!.validate()) {
                          final repo = MateriaRepository();

                          final materiaForm = MateriaModels(
                            nombre: nombreController.text,
                            docente: docenteController.text,
                            estado: estadoController.text,
                          );

                          if (esEditar) {
                            materiaForm.id_materia =
                                materia!.id_materia;
                            await repo.edit(materiaForm);
                          } else {
                            await repo.create(materiaForm);
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: Text("Aceptar"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
