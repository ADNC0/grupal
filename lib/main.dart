import 'package:flutter/material.dart';

import 'screens/multa/multa_form_screen.dart';
import 'screens/multa/multa_screen.dart';
import 'screens/estudiante/estudiante_form_screen.dart';
import 'screens/estudiante/estudiante_screen.dart';
import 'screens/tipo_multa/tipo_multa_form_screen.dart';
import 'screens/tipo_multa/tipo_multa_screen.dart';
import 'screens/materia/materia_form_screen.dart';
import 'screens/materia/materia_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: {
        '/': (context) => MultaScreen(),

        '/multa': (context) => MultaScreen(),
        '/multa/form': (context) => MultaFormScreen(),

        '/estudiante': (context) => EstudianteScreen(),
        '/estudiante/form': (context) => EstudianteFormScreen(),

        '/materia': (context) => MateriaScreen(),
        '/materia/form': (context) => MateriaFormScreen(),

        '/tipo_multa': (context) => TipoMultaScreen(),
        '/tipo_multa/form': (context) => TipoMultaFormScreen(),
      },
    );
  }
}
