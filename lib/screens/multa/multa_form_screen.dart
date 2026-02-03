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

  int? estudianteId;
  String? nombreEstudiante;
  int? materiaId;
  int? tipoId;

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
      estudianteId = multa!.id_estudiante;
      nombreEstudiante = multa!.nombre_estudiante;
      materiaId = multa!.id_materia;
      tipoId = multa!.id_tipo;
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
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2030),
                );
                if (fecha != null) {
                  fechaController.text =
                      "${fecha.day}/${fecha.month}/${fecha.year}";
                }
              },
              validator: (v) => v == null || v.isEmpty ? 'Ingrese la fecha' : null,
            ),
              const SizedBox(height: 15),
              TextFormField(
                controller: valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                validator: (v) => v == null || v.isEmpty ? 'Ingrese el valor' : null,
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<int>(
                value: estudianteId,
                items: estudiantes
                    .map((e) => DropdownMenuItem(
                          value: e.id_estudiante, 
                          child: Text(e.nombre),
                        ))
                    .toList(),
                onChanged: (v) => estudianteId = v,
                validator: (v) => v == null ? 'Seleccione estudiante' : null,
                decoration: const InputDecoration(labelText: 'Estudiante'),
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<int>(
                value: materiaId,
                items: materias
                    .map((e) => DropdownMenuItem(
                          value: e.id_materia,
                          child: Text(e.nombre),
                        ))
                    .toList(),
                onChanged: (v) => materiaId = v,
                validator: (v) => v == null ? 'Seleccione materia' : null,
                decoration: const InputDecoration(labelText: 'Materia'),
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<int>(
                value: tipoId,
                items: tipos
                    .map((e) => DropdownMenuItem(
                          value: e.id_tipo,
                          child: Text(e.descripcion),
                        ))
                    .toList(),
                onChanged: (v) => tipoId = v,
                validator: (v) => v == null ? 'Seleccione tipo multa' : null,
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
                          id_estudiante: estudianteId!,
                          nombre_estudiante: nombreEstudiante!,
                          id_materia: materiaId!,
                          id_tipo: tipoId!,
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
