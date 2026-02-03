import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Column(
          children: [
            Text("BIENVENIDO", style: TextStyle(color: Colors.white)),
            SizedBox(height: 4),
            Text("Seleccione una opción", style: TextStyle(color: Colors.white70, fontSize: 14)),
            SizedBox(height: 4),
            Container(
              height: 2,
              color: Colors.redAccent, 
              width: 150,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/estudiante');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "ESTUDIANTE",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/materia');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "MATERIA",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/tipo_multa');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "TIPO MULTA",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/multa');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "MULTA",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
     floatingActionButton: FloatingActionButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Acerca de la App"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Desarrollo de una app para las multas del curso"),
              SizedBox(height: 5),
              Text("Las multas se gestionan a partir del estudiante seleccionado,"),
              Text("y se muestran mediante un filtrado de registros asociados a dicho estudiante."),
              SizedBox(height: 5),
              Text("Desarrollado por: Abraham Nacimba"),
              Text(" Jonathan Alay "),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  },
  backgroundColor: Colors.black,
  shape: CircleBorder(),
  child: Icon(Icons.group, color: Colors.white),
),

    );
  }
}
