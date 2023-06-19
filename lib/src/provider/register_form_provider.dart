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
    'password'         : '',
    'numero_control'   : ''
  };

  int grupoIdSeleccionado = 0;

  List<int> gruposIdsSeleccionados = [];

  TypeUser typeUserSelected = TypeUser.alumno;

  void changeUserSelected(TypeUser? newTypeUserSelected) {
    typeUserSelected = newTypeUserSelected ?? TypeUser.alumno;
    notifyListeners();
  }

  void changeGrupoSelected(int? newIdGrupoSelected) async {
    grupoIdSeleccionado = newIdGrupoSelected ?? 0;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}