import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justificacion_app/src/provider/ui_provider.dart';
import 'package:justificacion_app/src/widgets/radio_user.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(
                    'assets/svg/join.svg',
                    height: 250.0,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'Crear Nueva Cuenta',
                    style: hedding1(),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Eliga el tipo de usuario',
                    style: textGraySmall(),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const RadioButtonsUser(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Datos personales del alumno',
                    style: textGraySmall(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: inputWithBorder('Nombre(s)'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: inputWithBorder('Apellido Paterno'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: inputWithBorder('Apellido Materno'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (uiProvider.isVisibleInpustRegister)
                    TextFormField(
                      decoration: inputWithBorder('Número de control Escolar'),
                    ),
                  if (uiProvider.isVisibleInpustRegister)
                    const SizedBox(
                      height: 20.0,
                    ),
                  if (uiProvider.isVisibleInpustRegister)
                    TextFormField(
                      decoration: inputWithBorder('Carrera Profesional'),
                    ),
                  if (uiProvider.isVisibleInpustRegister)
                    const SizedBox(
                      height: 20.0,
                    ),
                  if (uiProvider.isVisibleInpustRegister)
                    TextFormField(
                      decoration: inputWithBorder('Semestre'),
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: btnPurple(),
                    child: const Text('Crear Cuenta'),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ));
  }
}
