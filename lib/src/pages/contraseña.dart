import 'package:flutter/material.dart';

class CambiarContrasena extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recuperar Contraseña',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CambiarContrasenaPage(),
    );
  }
}

class CambiarContrasenaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg',
              width: 279,
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Olvidé mi',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 47, 107),
                    ),
                  ),
                  Text(
                    'Contraseña',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 47, 107),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 250,
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 62, 0, 133),
                padding: EdgeInsets.symmetric(horizontal: 105, vertical: 10),
              ),
              child: const Text(
                'Enviar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Recordaste tu contraseña?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'O',
              style: TextStyle(color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿No Tienes Cuenta?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Crear Cuenta',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
