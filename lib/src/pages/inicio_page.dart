import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/5087/5087579.png', // URL de la imagen
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Lógica para el texto "¿Olvidaste tu contraseña?"
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para el botón "Iniciar Sesión"
              },
              child: Text('Iniciar Sesión'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Cambiar el color de fondo del botón
                onPrimary: Colors.white, // Cambiar el color del texto del botón
              ),
            ),
          ],
        ),
      ),
    );
  }
}
