import 'package:flutter/material.dart';

import '../../models/multa_models.dart';
import '../../models/estudiante_models.dart';
import '../../models/materia_models.dart';
import '../../models/tipo_multa_models.dart';

import '../../repositories/multa_repository.dart';
import '../../repositories/estudiante_repository.dart';
import '../../repositories/materia_repository.dart';
import '../../repositories/tipo_multa_repository.dart';

class MultaFormScreen extends StatefulWidget {
  const MultaFormScreen({super.key});

  @override
  State<MultaFormScreen> createState() => _MultaFormScreenState();
}

class _MultaFormScreenState extends State<MultaFormScreen> {
  final formKey = GlobalKey<FormState>();

  final fechaController = TextEditingController();
  final valorController = TextEditingController();
  int? id_estudiante;
  int? id_materia;
  int? id_tipo;

  List<EstudianteModels> estudiantes = [];
  List<MateriaModels> materias = [];
  List<TipoMultaModels> tipos = [];

  MultaModels? multa;

  @override
  void initState() {
    super.initState();
    cargarCombos();
  }

  Future<void> cargarCombos() async {
    estudiantes = await EstudianteRepository().getAll();
    materias = await MateriaRepository().getAll();
    tipos = await TipoMultaRepository().getAll();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      multa = args as MultaModels;
      fechaController.text = multa!.fecha;
      valorController.text = multa!.valor;
      id_estudiante = multa!.id_estudiante;
      id_materia = multa!.id_materia;
      id_tipo = multa!.id_tipo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEditar = multa != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ? 'Editar Multa' : 'Registrar Multa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // FECHA
              TextFormField(
                controller: fechaController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? fecha = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (fecha != null) {
                    fechaController.text =
                        '${fecha.day}/${fecha.month}/${fecha.year}';
                  }
                },
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingrese la fecha' : null,
              ),

              const SizedBox(height: 15),

              // VALOR
              TextFormField(
                controller: valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingrese el valor' : null,
              ),

              const SizedBox(height: 15),
              DropdownButtonFormField<int>(
                value: id_estudiante,
                items: estudiantes.map((e) {
                  return DropdownMenuItem(
                    value: e.id_estudiante,
                    child: Text(e.nombre),
                  );
                }).toList(),
                onChanged: (v) {
                  id_estudiante = v;
                },
                validator: (v) =>
                    v == null ? 'Seleccione estudiante' : null,
                decoration: const InputDecoration(labelText: 'Estudiante'),
              ),

              const SizedBox(height: 15),
              DropdownButtonFormField<int>(
                value: id_materia,
                items: materias.map((e) {
                  return DropdownMenuItem(
                    value: e.id_materia,
                    child: Text(e.nombre),
                  );
                }).toList(),
                onChanged: (v) {
                  id_materia = v;
                },
                validator: (v) =>
                    v == null ? 'Seleccione materia' : null,
                decoration: const InputDecoration(labelText: 'Materia'),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<int>(
                value: id_tipo,
                items: tipos.map((e) {
                  return DropdownMenuItem(
                    value: e.id_tipo,
                    child: Text(e.descripcion),
                  );
                }).toList(),
                onChanged: (v) {
                  id_tipo = v;
                },
                validator: (v) =>
                    v == null ? 'Seleccione tipo multa' : null,
                decoration: const InputDecoration(labelText: 'Tipo Multa'),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;

                        final multaForm = MultaModels(
                          fecha: fechaController.text,
                          valor: valorController.text,
                          id_estudiante: id_estudiante!,
                          id_materia: id_materia!,
                          id_tipo: id_tipo!,
                        );

                        final repo = MultaRepository();

                        if (esEditar) {
                          multaForm.id_multa = multa!.id_multa;
                          await repo.edit(multaForm);
                        } else {
                          await repo.create(multaForm);
                        }

                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Aceptar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
