import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justificacion_app/src/styles/styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Inicio de Sesión'),
      // ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 80.0,
                  ),
                  SvgPicture.asset('assets/svg/login.svg', height: 240.0),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Iniciar Sesión',
                    style: hedding1(),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    decoration: inputWithBorder('Correo Electronico',
                        iconData: Icons.email),
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Introduzca un email correcto'
                            : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration:
                        inputWithBorder('Contraseña', iconData: Icons.lock),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Lógica para el texto "¿Olvidaste tu contraseña?"
                      Navigator.pushNamed(context, 'forget-password');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para el botón "Iniciar Sesión"
                    },
                    style: btnPurple(),
                    child: const Text('Iniciar Sesión'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿No Tienes Cuenta?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'register'),
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
          ),
        ),
      ),
    );
  }
}
