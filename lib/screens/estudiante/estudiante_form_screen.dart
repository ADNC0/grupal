import 'package:flutter/material.dart';

import '../../models/estudiante_models.dart';
import '../../repositories/estudiante_repository.dart';

class EstudianteFormScreen extends StatefulWidget {
  const EstudianteFormScreen({super.key});

  @override
  State<EstudianteFormScreen> createState() => _EstudianteFormScreenState();
}

class _EstudianteFormScreenState extends State<EstudianteFormScreen> {
  final formEstudiante = GlobalKey<FormState>();
  final cedulaController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final cursoController = TextEditingController();
  final paraleloController = TextEditingController();
  EstudianteModels? estudiante;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      estudiante = args as EstudianteModels;
      cedulaController.text = estudiante!.cedula;
      nombreController.text = estudiante!.nombre;
      apellidoController.text = estudiante!.apellido;
      cursoController.text = estudiante!.curso;
      paraleloController.text = estudiante!.paralelo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEditar = estudiante != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ? "editar estudiante" : "insertar estudiante"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formEstudiante,
          child: Column(
            children: [
              TextFormField(
                controller: cedulaController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'La cédula es requerida';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Cédula",
                  hintText: "Ingrese la cédula del estudiante",
                  prefixIcon: Icon(Icons.card_membership),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
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
                  hintText: "Ingrese el nombre del estudiante",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: apellidoController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'El apellido es requerido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Apellido",
                  hintText: "Ingrese el apellido del estudiante",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: cursoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El curso es requerido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Curso",
                  hintText: "Ingrese el nombre del curso",
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: paraleloController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El paralelo es requerido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Paralelo",
                  hintText: "Ingrese el paralelo del estudiante",
                  prefixIcon: Icon(Icons.category),
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
                        if (formEstudiante.currentState!.validate()) {
                          final repo = EstudianteRepository();

                          final estudianteForm = EstudianteModels(
                            cedula: cedulaController.text,
                            nombre: nombreController.text,
                            apellido: apellidoController.text,
                            curso: cursoController.text,
                            paralelo: paraleloController.text,
                          );

                          if (esEditar) {
                            estudianteForm.id_estudiante =
                                estudiante!.id_estudiante;
                            await repo.edit(estudianteForm);
                          } else {
                            await repo.create(estudianteForm);
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
