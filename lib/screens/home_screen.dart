import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menú de opciones", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/estudiante');
              },
              child: Text("Ir a Estudiante"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/materia');
              },
              child: Text("Ir a Materia"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tipo_multa');
              },
              child: Text("Ir a Tipo Multa"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/multa');
              },
              child: Text("Ir a Multa"),
            ),
          ],
        ),
      ),
    );
  }
}
