import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justificacion_app/src/provider/register_form_provider.dart';
import 'package:justificacion_app/src/services/cuentas_service.dart';
import 'package:justificacion_app/src/services/grupos_service.dart';
import 'package:justificacion_app/src/widgets/alert_dialog_custom.dart';
import 'package:justificacion_app/src/widgets/radio_user.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _initPage();
    });
  }

  _initPage() async {
    final gruposService = Provider.of<GruposService>(context, listen: false);
    await gruposService.cargarGruposSinAuth();
  }

  @override
  Widget build(BuildContext context) {
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);
    final gruposService = Provider.of<GruposService>(context);
    final cuentasService = Provider.of<CuentasService>(context, listen: false);
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
              autovalidateMode: AutovalidateMode.always,
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
                    initialValue: registerFormProvider.user['nombre'],
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
                  TextFormField(
                    decoration: inputWithBorder('Correo Electrónico'),
                    onChanged: ( value ) => user['email'] = value,
                    validator: ( value ) {
                      if( value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: inputWithBorder('Contraseña'),
                    onChanged: ( value ) => user['password'] = value,
                    validator: ( value ) {
                      if( value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  if(registerFormProvider.typeUserSelected == TypeUser.alumno)
                  TextFormField(
                    decoration: inputWithBorder('Número de control'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 14,
                    onChanged: ( value ) => user['numero_control'] = value,
                    validator: ( value ) {
                      if( value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  if(registerFormProvider.typeUserSelected == TypeUser.alumno)
                  const SizedBox(height: 20.0,),
                  if(registerFormProvider.typeUserSelected == TypeUser.alumno)
                  DropdownButtonFormField(
                    items: gruposService.grupos.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.nombre),
                    )).toList(),
                    onChanged: (value) {
                      registerFormProvider.changeGrupoSelected(value);
                    },
                    validator: (value) {
                      if(value == null) {
                        return 'Debes escoger un grupo';
                      }
                      return null;
                    },
                  ),
                  if(registerFormProvider.typeUserSelected == TypeUser.profesor)
                  const SizedBox(height: 20.0,),
                  if(registerFormProvider.typeUserSelected == TypeUser.profesor)
                  MultiSelectDialogField<int>(
                    items: gruposService.grupos.map((e) => MultiSelectItem(e.id, e.nombre)).toList(), 
                    onConfirm: (values) {
                      registerFormProvider.gruposIdsSeleccionados = values;
                    },
                    validator: (value) {
                      if(value == null) {
                        return 'Debes escoger aunque sea un grupo';
                      }
                      if(value.isEmpty) {
                        return 'Debes escoger aunque sea un grupo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () async {
                      if(registerFormProvider.isValidForm()) {
                        if(registerFormProvider.typeUserSelected == TypeUser.alumno) {
                          final response = await cuentasService
                            .registrarAlumno(registerFormProvider.user, registerFormProvider.grupoIdSeleccionado);
                          
                          if(response.success) {
                            if(context.mounted) {
                              Navigator.pop(context);
                              showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '!Correcto!', message: response.message,));
                            }
                          } else {
                            if(context.mounted) {
                              showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '!Error¡', message: response.message));
                            }
                          }
                        }
                        if(registerFormProvider.typeUserSelected == TypeUser.profesor) {
                          final response = await cuentasService
                            .registerProfesor(registerFormProvider.user, registerFormProvider.gruposIdsSeleccionados);

                          if(response.success) {
                            if(context.mounted) {
                              gruposService.grupos.clear();
                              Navigator.pop(context);
                              showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '!Correcto!', message: response.message,));
                            }
                          } else {
                            if(context.mounted) {
                              showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '!Error¡', message: response.message));
                            }
                          }
                        }
                      } else {
                        showDialog(context: context, builder: ( _ ) => const AlertDialogCustom(
                          title: '¡Aviso!', 
                          message: 'Tienes que llenar todos los campos del formulario',)
                        );
                      }
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