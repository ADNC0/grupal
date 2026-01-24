import 'package:flutter/material.dart';

import '../../models/multa_models.dart';
import '../../repositories/multa_repository.dart';

class MultaFormScreen extends StatefulWidget {
  const MultaFormScreen({super.key});

  @override
  State<MultaFormScreen> createState() => _MultaFormScreenState();
}

class _MultaFormScreenState extends State<MultaFormScreen> {
  final formKey = GlobalKey<FormState>();
  final fechaController = TextEditingController();
  final valorController = TextEditingController();
  final idEstudianteController = TextEditingController();
  final idMateriaController = TextEditingController();
  final idTipoController = TextEditingController();

  MultaModels? multa;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      multa = args as MultaModels;
      fechaController.text = multa!.fecha;
      valorController.text = multa!.valor;
      idEstudianteController.text = multa!.id_estudiante.toString();
      idMateriaController.text = multa!.id_materia.toString();
      idTipoController.text = multa!.id_tipo.toString();
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
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  hintText: 'YYYY-MM-DD',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingrese la fecha' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: valorController,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  hintText: 'Ej: 5',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingrese el valor' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: idEstudianteController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID Estudiante',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingrese el id del estudiante' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: idMateriaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID Materia',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingrese el id de la materia' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: idTipoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID Tipo Multa',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingrese el id del tipo' : null,
              ),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;

                        final repo = MultaRepository();

                        final multaForm = MultaModels(
                          fecha: fechaController.text,
                          valor: valorController.text,
                          id_estudiante:
                              int.parse(idEstudianteController.text),
                          id_materia: int.parse(idMateriaController.text),
                          id_tipo: int.parse(idTipoController.text),
                        );

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
