import 'package:flutter/material.dart';

import '../../models/tipo_multa_models.dart';
import '../../repositories/tipo_multa_repository.dart';

class TipoMultaFormScreen extends StatefulWidget {
  const TipoMultaFormScreen({super.key});

  @override
  State<TipoMultaFormScreen> createState() => _TipoMultaFormScreenState();
}

class _TipoMultaFormScreenState extends State<TipoMultaFormScreen> {
  final formTipoMulta = GlobalKey<FormState>();
  final descripcionController = TextEditingController();
  final gravedadController = TextEditingController();
  final estadoController = TextEditingController();
  TipoMultaModels? tipoMulta;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      tipoMulta = args as TipoMultaModels;
      descripcionController.text = tipoMulta!.descripcion;
      gravedadController.text = tipoMulta!.gravedad;
      estadoController.text = tipoMulta!.estado;
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEditar = tipoMulta != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ? "editar tipo multa" : "insertar tipo multa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formTipoMulta,
          child: Column(
            children: [
              TextFormField(
                controller: descripcionController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'La descripcion es requerida';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Descripcion",
                  hintText: "Ingrese la descripcion del tipo de multa",
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: gravedadController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La gravedad es requerida';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Gravedad",
                  hintText: "Ingrese la gravedad del tipo de multa",
                  prefixIcon: Icon(Icons.abc),
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
                  hintText: "Ingrese el estado del tipo de multa",
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
                        if (formTipoMulta.currentState!.validate()) {
                          final repo = TipoMultaRepository();

                          final tipoMultaForm = TipoMultaModels(
                            descripcion: descripcionController.text,
                            gravedad: gravedadController.text,
                            estado: estadoController.text,
                          );

                          if (esEditar) {
                            tipoMultaForm.id_tipo = tipoMulta!.id_tipo;
                            await repo.edit(tipoMultaForm);
                          } else {
                            await repo.create(tipoMultaForm);
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
