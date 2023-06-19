import 'package:flutter/material.dart';
import 'package:justificacion_app/src/models/justificacion_model.dart';
import 'package:justificacion_app/src/provider/user_data_provider.dart';
import 'package:justificacion_app/src/services/justificaciones_service.dart';
import 'package:justificacion_app/src/services/users_service.dart';
import 'package:justificacion_app/src/styles/styles.dart';
import 'package:justificacion_app/src/widgets/alert_dialog_custom.dart';
import 'package:provider/provider.dart';

import '../provider/justificaciones_form_provider.dart';

class JustificacionesFormPage extends StatefulWidget {
  const JustificacionesFormPage({super.key});

  @override
  State<JustificacionesFormPage> createState() => _JustificacionFormPageState();
}

class _JustificacionFormPageState extends State<JustificacionesFormPage> {
  final TextEditingController _inputDateInicio = TextEditingController();
  final TextEditingController _inputDateFin = TextEditingController();
  TextEditingController textFormTextFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final JustificacionModel? justificacionArgument = ModalRoute.of(context)?.settings.arguments as JustificacionModel?;
    final justificacionesForm = Provider.of<JustificacionesFormProvider>(context, listen: false);
    final userService = Provider.of<UsersService>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final justificacionesService = Provider.of<JustificacionesService>(context);
    
    if(justificacionArgument != null) {
      justificacionesForm.justificacion = justificacionArgument;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "JustificacionesApp",
          style: TextStyle(color: Colors.indigoAccent),
        ),
      ),
      body: Center(
        child: Form(
          key: justificacionesForm.justificacionesFormKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            children: <Widget>[
              const Text(
                "Nueva Justificacion",
                style: TextStyle(fontSize: 40, color: Colors.indigoAccent),
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 10, height: 50),
              _campoIdentificador(justificacionesForm),
              const Divider(),
              _campoFechaInicio(justificacionesForm),
              const Divider(),
              _crearFin(justificacionesForm),
              const Divider(),
              _crearMotivo(context),
              const Divider(),
              Text('Seleccione su profesor:', style: textGraySmall(),),
              DropdownButtonFormField(
                items: userService.users.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                value: e.id,
                child: Text('${e.nombre} ${e.apellidoPaterno} ${e.apellidoMaterno}'),
               )).toList(),
                    onChanged: (value) {
                      justificacionesForm.changeProfesorSelected(value);
                    },
                    validator: (value) {
                      if(value == null) {
                        return 'Debes escoger un profesor';
                      }
                      return null;
                    },
                  ),
              const SizedBox(height: 16.0),
              _crearBoton(context, justificacionesForm, userDataProvider, justificacionesService),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoIdentificador(JustificacionesFormProvider justificacionesFormProvider) {
    return TextFormField(
      //autofocus: true,
      validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Identificador",
        labelText: "Identificador",
      ),
      onChanged: (valor) {
        justificacionesFormProvider.justificacion.identificador = valor;
      },
    );
  }

  Widget _campoFechaInicio(JustificacionesFormProvider justificacionesFormProvider) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _inputDateInicio,
      validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Fecha de Inicio",
        labelText: "Fecha de Inicio",
        suffixIcon: const Icon(Icons.calendar_month),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _dateInicio(context, justificacionesFormProvider);
      },
    );
  }

  _dateInicio(BuildContext context, JustificacionesFormProvider justificacionesFormProvider) async {

    DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      locale: const Locale('es', 'ES'),
    ));

    if (picked != null) {
      setState(() {
        justificacionesFormProvider.justificacion.fechaInicio = picked;
        _inputDateInicio.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Widget _crearFin(JustificacionesFormProvider justificacionesFormProvider) {
    return TextFormField(
      enableInteractiveSelection: false,
      validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
      controller: _inputDateFin,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Fecha de Fin",
        labelText: "Fecha de Fin",
        suffixIcon: const Icon(Icons.calendar_month),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _dateFin(context, justificacionesFormProvider);
      },
    );
  }

  _dateFin(BuildContext context, JustificacionesFormProvider justificacionesFormProvider) async {

    DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      locale: const Locale('es', 'ES'),
    ));

    if (picked != null) {
      setState(() {
        justificacionesFormProvider.justificacion.fechaFin = picked;
        _inputDateFin.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Widget _crearMotivo(BuildContext context) {
    final justificacionesForm = Provider.of<JustificacionesFormProvider>(context);
    return TextFormField(
      validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Motivo",
        labelText: "Motivo",
      ),
      onChanged: (valor) {
        justificacionesForm.justificacion.motivo = valor;
      },
    );
  }

  Widget _crearBoton(
    BuildContext context, 
    JustificacionesFormProvider justificacionesFormProvider, 
    UserDataProvider userData,
    JustificacionesService justificacionesService) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
    ),
    onPressed: () async {
      if(justificacionesFormProvider.isValidForm()) {
        final response = await justificacionesService.crear(justificacionesFormProvider.justificacion);
        if(response.success) {
          if(context.mounted) {
            justificacionesService.cargarJustificaciones(context);
          }
          if(context.mounted) {
            Navigator.pop(context);
            showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '!Correcto!', message: response.message));
          }
        } else {
          if(context.mounted) {
            showDialog(context: context, builder: ( _ ) => AlertDialogCustom(title: '!Error!', message: response.message));
          }
        }
      } else {
        showDialog(context: context, builder: ( _ ) => const AlertDialogCustom(title: '!Error!', message: 'Faltan campos por llenar'));
      }
    },
    child: const Text('Enviar'),
  );
}
}


