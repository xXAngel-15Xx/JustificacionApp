import 'package:flutter/material.dart';
import 'package:justificacion_app/src/models/user_model.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey =
   GlobalKey<FormState>();

  UserModel user = UserModel(
    id: 0,
    apellidoMaterno: '',
    apellidoPaterno: '',
    email: '',
    nombres: '',
    password: '',
    role: ''
  );

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void sumitForm() {
    
  }
}