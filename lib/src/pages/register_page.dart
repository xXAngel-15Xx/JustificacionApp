import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justificacion_app/src/models/grupo_model.dart';
import 'package:justificacion_app/src/provider/register_form_provider.dart';
import 'package:justificacion_app/src/services/grupos_service.dart';
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
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);
    final gruposService = Provider.of<GruposService>(context);

    final user = registerFormProvider.user;

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
            child: Form(
              key: registerFormProvider.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset('assets/svg/join.svg', height: 250.0,),
                  const SizedBox(height: 40.0,),
                  Text('Crear Cuenta', style: hedding1(),),
                  const SizedBox(height: 10.0,),
                  Text('Elige tu tipo de usuario', style: textGraySmall(),),
                  const SizedBox(height: 10.0,),
                  const RadioButtonsUser(),
                  const SizedBox(height: 20.0,),
                  Text('Datos personales', style: textGraySmall(),),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: inputWithBorder('Nombre'),
                    onChanged: ( value ) => user['nombre'] = value,
                    validator: ( value ) {
                      if( value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: inputWithBorder('Apellido Paterno'),
                    onChanged: ( value ) => user['apellido_paterno'] = value,
                    validator: ( value ) {
                      if( value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: inputWithBorder('Apellido Materno'),
                    onChanged: ( value ) => user['apellido_materno'] = value,
                    validator: ( value ) {
                      if( value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  if(registerFormProvider.userSelected == TypeUser.alumno)
                  TextFormField(
                    decoration: inputWithBorder('Número de control'),
                    onChanged: ( value ) => user['numero_control'] = value,
                    validator: ( value ) {
                      if( value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  if(registerFormProvider.userSelected == TypeUser.alumno)
                  const SizedBox(height: 20.0,),
                  if(registerFormProvider.userSelected == TypeUser.alumno)
                  DropdownButtonFormField(
                    items: gruposService.grupos.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.nombre),
                    )).toList(),
                    onChanged: (value) {
                      gruposService.changeGrupoSelected(value);
                    }
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () {
                      
                    }, 
                    style: btnPurple(),
                    child: const Text('Crear Cuenta'),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}