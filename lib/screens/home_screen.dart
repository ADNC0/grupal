import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 38, 170, 235),
        centerTitle: true,
        title: Column(
          children: const [
            Text("BIENVENIDO", style: TextStyle(color: Colors.white)),
            SizedBox(height: 4),
            Text(
              "Seleccione una opción",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/multa.png', height: 180, width: 180),
            const SizedBox(height: 50),
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
                      color: Colors.green.shade400,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person, color: Colors.white, size: 32),
                        SizedBox(height: 8),
                        Text(
                          "ESTUDIANTE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/materia');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.book, color: Colors.white, size: 32),
                        SizedBox(height: 8),
                        Text(
                          "MATERIA",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                      color: Colors.orange.shade400,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.warning, color: Colors.white, size: 32),
                        SizedBox(height: 8),
                        Text(
                          "TIPO MULTA",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/multa');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.attach_money,
                            color: Colors.white, size: 32),
                        SizedBox(height: 8),
                        Text(
                          "MULTA",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.group, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Acerca de la App"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Desarrollo de una app para las multas del curso"),
                    SizedBox(height: 5),
                    Text(
                        "Las multas se gestionan a partir del estudiante seleccionado,"),
                    Text(
                        "Las multas se asignan según la materia y el tipo de multa."),
                    SizedBox(height: 5),
                    Text("Desarrollado por:"),
                    Text("Nacimba Abraham"),
                    Text("Alay Jonathan"),
                    Text("Espin Anthony"),
                    Text("Tipan Paul"),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cerrar"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
