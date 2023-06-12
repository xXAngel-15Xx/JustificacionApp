import 'package:flutter/material.dart';
import 'package:justificacion_app/src/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class RadioButtonsUser extends StatefulWidget {
  const RadioButtonsUser({super.key});

  @override
  State<RadioButtonsUser> createState() => _RadioButtonsUserState();
}

enum TypeUser { alumno,  profesor, administrador }

class _RadioButtonsUserState extends State<RadioButtonsUser> {
  TypeUser? _userSelected = TypeUser.alumno;

  @override
  Widget build(BuildContext context) {
    

    return Column(
      children: [
        _radioBtn(TypeUser.alumno, 'Alumno'),
        _radioBtn(TypeUser.profesor, 'Profesor')
      ],
    );
  }
  Widget _radioBtn(TypeUser user, String label) {
    final uiProvider = Provider.of<UIProvider>(context);
  return ListTile(
          title: Text(label),
          leading: Radio<TypeUser>(
            value: user,
            groupValue: _userSelected,
            onChanged: (TypeUser? value) {
              setState(() {
                _userSelected = value;
              });
              if(value == TypeUser.profesor) {
                uiProvider.isVisibleInpustRegister = false;
              } else {
                uiProvider.isVisibleInpustRegister = true;
              }
            },
          ),
        );
}
}

