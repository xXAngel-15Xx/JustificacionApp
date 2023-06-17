import 'package:flutter/material.dart';

enum TypeUser { alumno,  profesor, administrador }

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey =
   GlobalKey<FormState>();

  Map<String, String> user = {
    'nombre'           : '',
    'apellido_paterno' : '',
    'apellido_materno' : '',
    'email'            : '',
    'numero_control'   : ''
  };

  int grupoIdSeleccionado = 0;

  List<int> gruposIdsSeleccionados = [];

  TypeUser userSelected = TypeUser.alumno;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}