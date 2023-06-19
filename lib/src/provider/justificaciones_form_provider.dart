import 'package:flutter/material.dart';
import 'package:justificacion_app/src/models/justificacion_model.dart';

class JustificacionesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> justificacionesFormKey = GlobalKey<FormState>();
  
  JustificacionModel justificacion = JustificacionModel(
    id: 0, 
    identificador: '', 
    fechaInicio: DateTime.now(), 
    fechaFin: DateTime.now(), 
    motivo: '', 
    profesorId: 0, 
    alumnoId: 0
  );

  void changeProfesorSelected(int? idProfesorSelected) async {
    justificacion.profesorId = idProfesorSelected ?? 0;
    notifyListeners();
  }

  bool isValidForm() {
    return justificacionesFormKey.currentState?.validate() ?? false;
  }
}